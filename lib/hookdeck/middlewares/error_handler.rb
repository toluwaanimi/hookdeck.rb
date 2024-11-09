# frozen_string_literal: true

module HookDeck
  module Middleware
    # ErrorHandler is a Faraday middleware that provides standardized error handling
    # for HTTP requests. It catches Faraday errors and converts them into specific
    # HookDeck error types based on the response status and error type
    #
    class ErrorHandler < Faraday::Middleware
      # Executes the middleware
      # @param env [Hash] The Faraday environment hash
      # @raise [HookDeck::Error] Various error types based on the response
      def call(env)
        @app.call(env)
      rescue Faraday::Error => e
        handle_error(e, env)
      end

      private

      # Maps Faraday errors to HookDeck-specific errors
      # @param error [Faraday::Error] The original Faraday error
      # @param _env [Hash] The Faraday environment hash
      # @raise [HookDeck::Error] Converted error type
      def handle_error(error, _env)
        case error
        when Faraday::ClientError
          handle_client_error(error.response)
        when Faraday::ServerError
          handle_server_error(error.response)
        when Faraday::ConnectionFailed
          raise ConnectionError, error
        when Faraday::TimeoutError
          raise TimeoutError, error
        when Faraday::SSLError
          raise SSLError, error
        else
          raise Error, error.message
        end
      end

      # Maps HTTP status codes to specific client errors
      # @param response [Hash] The error response hash
      # @raise [HookDeck::Error] Specific client error type
      def handle_client_error(response)
        error_class = case response[:status]
        when 400 then BadRequestError
        when 401 then UnauthorizedError
        when 403 then ForbiddenError
        when 404 then NotFoundError
        when 409 then ConflictError
        when 422 then UnprocessableEntityError
        when 429 then RateLimitError
        else ApiError
        end

        raise error_class, response
      end

      # Handles server-side errors
      # @param response [Hash] The error response hash
      # @raise [HookDeck::ServerError] Server error
      def handle_server_error(response)
        raise ServerError, response
      end
    end
  end
end
