# frozen_string_literal: true

module HookDeck
  module Middleware
    # Middleware that automatically generates and manages request IDs for HTTP requests.
    # Adds both server and client request IDs to facilitate request tracking and debugging.
    #
    class RequestId < Faraday::Middleware
      # Initialize the request ID middleware
      # @param app [#call] The Faraday app
      # @param options [Hash] Configuration options
      # @option options [String] :prefix ('req') Prefix for generated request IDs
      def initialize(app, options = {})
        super(app)
        @prefix = options.fetch(:prefix, "req")
      end

      # Executes the middleware, adding and tracking request IDs
      def call(env)
        env.request_headers["X-Request-Id"] ||= generate_request_id
        env.request_headers["X-Client-Request-Id"] ||= generate_request_id

        @app.call(env).on_complete do |response_env|
          # Store request IDs for potential error handling
          response_env[:hookdeck_request_id] = response_env.response_headers["x-request-id"]
          response_env[:hookdeck_client_request_id] = env.request_headers["X-Client-Request-Id"]
        end
      end

      private

      # Generates a unique request ID with configured prefix
      # @return [String] Request ID in format "prefix_hexstring"
      def generate_request_id
        "#{@prefix}_#{SecureRandom.hex(16)}"
      end
    end
  end
end
