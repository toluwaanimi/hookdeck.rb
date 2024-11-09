# frozen_string_literal: true

module HookDeck
  module Middleware
    # Logging middleware that provides detailed request/response logging with security-aware filtering.
    # Automatically redacts sensitive information from headers and request/response bodies.
    #
    class Logging < Faraday::Middleware
      # Initialize the logging middleware
      # @param app [#call] The Faraday app
      # @param logger [Logger, nil] Optional custom logger (defaults to STDOUT logger)
      def initialize(app, logger: nil)
        super(app)
        @logger = logger || default_logger
      end

      # Executes the middleware, logging request and response details
      # @param env [Hash] The Faraday environment hash
      def call(env)
        start_time = Time.now
        log_request(env)

        @app.call(env).on_complete do |response_env|
          duration = Time.now - start_time
          log_response(response_env, duration)
        end
      rescue => e
        log_error(e)
        raise
      end

      private

      # Logs request details with sensitive data filtered
      def log_request(env)
        @logger.info do
          {
            method: env.method.upcase,
            url: env.url.to_s,
            body: sanitize_body(env.body),
            headers: sanitize_headers(env.request_headers),
            request_id: env.request_headers["X-Request-Id"]
          }.to_json
        end
      end

      # Logs response details with timing information
      def log_response(env, duration)
        @logger.info do
          {
            method: env.method.upcase,
            url: env.url.to_s,
            status: env.status,
            duration: duration.round(3),
            headers: sanitize_headers(env.response_headers),
            request_id: env.request_headers["X-Request-Id"]
          }.to_json
        end
      end

      # Logs error details with backtrace
      # @param error [StandardError] The caught error
      def log_error(error)
        @logger.error do
          {
            error: error.class.name,
            message: error.message,
            backtrace: error.backtrace&.first(5)
          }.to_json
        end
      end

      # Sanitizes request/response body by filtering sensitive data
      # @param body [String, nil] The raw body
      # @return [Hash, String, nil] Sanitized body
      def sanitize_body(body)
        return nil if body.nil?
        return body unless body.is_a?(String)

        begin
          parsed = JSON.parse(body)
          sanitize_hash(parsed)
        rescue JSON::ParserError
          "Unparseable body"
        end
      end

      # Recursively sanitizes hash values
      # @param hash [Hash] Hash to sanitize
      # @return [Hash] Sanitized hash
      def sanitize_hash(hash)
        hash.each_with_object({}) do |(key, value), sanitized|
          sanitized[key] = if sensitive_key?(key)
            "[FILTERED]"
          elsif value.is_a?(Hash)
            sanitize_hash(value)
          elsif value.is_a?(Array)
            value.map { |v| v.is_a?(Hash) ? sanitize_hash(v) : v }
          else
            value
          end
        end
      end

      # Sanitizes headers by filtering sensitive values
      # @param headers [Hash] Headers to sanitize
      # @return [Hash] Sanitized headers
      def sanitize_headers(headers)
        headers.each_with_object({}) do |(key, value), sanitized|
          sanitized[key] = if sensitive_header?(key)
            "[FILTERED]"
          else
            value
          end
        end
      end

      # Checks if a key contains sensitive information
      # @param key [String, Symbol] Key to check
      # @return [Boolean] true if sensitive
      def sensitive_key?(key)
        key.to_s.downcase.match?(/password|token|key|secret|credential|auth/)
      end

      # Checks if a header contains sensitive information
      # @param header [String, Symbol] Header to check
      # @return [Boolean] true if sensitive
      def sensitive_header?(header)
        header.to_s.downcase.match?(/authorization|x-api-key|cookie/)
      end

      # Creates a default logger if none provided
      # @return [Logger] Configured logger
      def default_logger
        logger = Logger.new($stdout)
        logger.progname = "hookdeck"
        logger.formatter = proc do |severity, datetime, progname, msg|
          "#{datetime} [#{progname}] #{severity}: #{msg}\n"
        end
        logger
      end
    end
  end
end
