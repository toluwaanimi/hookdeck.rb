module Hookdeck
  class Error < StandardError
    attr_reader :message, :request_id

    def initialize(message = nil, request_id = nil)
      @message = message
      @request_id = request_id
      super(error_message)
    end

    private

    def error_message
      request_id ? "#{message} (Request ID: #{request_id})" : message
    end
  end

  class ValidationError < Error; end

  class ApiError < Error
    attr_reader :response,
      :handled,
      :status,
      :message,
      :data,
      :request_id

    def initialize(response = nil)
      @response = response
      parse_error_response(response&.dig(:body))
      @request_id = response&.dig(:headers, "x-request-id")
      super(message, request_id)
    end

    private

    def parse_error_response(body)
      error_data = parse_body(body)
      @handled = error_data["handled"]
      @status = error_data["status"]
      @message = error_data["message"]
      @data = error_data["data"]
    end

    def parse_body(body)
      return {} unless body

      body.is_a?(String) ? JSON.parse(body) : body
    rescue JSON::ParserError
      {
        "handled" => true,
        "status" => response&.dig(:status),
        "message" => body.to_s,
        "data" => {}
      }
    end
  end

  class BadRequestError < ApiError
    def initialize(response)
      super
      @status = 400
    end
  end

  class UnauthorizedError < ApiError
    def initialize(response)
      super
      @status = 401
    end
  end

  class ForbiddenError < ApiError
    def initialize(response)
      super
      @status = 403
    end
  end

  class NotFoundError < ApiError
    def initialize(response)
      super
      @status = 404
    end
  end

  class UnprocessableEntityError < ApiError
    def initialize(response)
      super
      @status = 422
    end
  end

  class RateLimitError < ApiError
    attr_reader :retry_after

    def initialize(response)
      super
      @status = 429
      @retry_after = response&.dig(:headers, "retry-after")&.to_i
    end
  end

  class ServerError < ApiError
    def initialize(response)
      super
      @status = response&.dig(:status) || 500
    end
  end

  class ConnectionError < Error
    attr_reader :original_error

    def initialize(error)
      @original_error = error
      super(error.message)
    end
  end

  class TimeoutError < ConnectionError; end

  class SSLError < ConnectionError; end
end
