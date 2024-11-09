module Hookdeck
  module Resources
    class Base
      attr_reader :client

      def initialize(client)
        @client = client
      end

      protected

      def get(path, params = {})
        request(:get, path, params)
      end

      def post(path, params = {})
        request(:post, path, params)
      end

      def put(path, params = {})
        request(:put, path, params)
      end

      def delete(path, params = {})
        request(:delete, path, params)
      end

      private

      def request(method, path, params = {}, opts = {})
        path = ensure_api_version(path)
        handle_response(
          client.request(
            method,
            path,
            params,
            opts
          )
        )
      end

      def ensure_api_version(path)
        "/#{client.config.api_version}/#{path.gsub(%r{^/}, "")}"
      end

      def handle_response(response)
        return nil if response.nil?

        response
      rescue => e
        handle_error(e)
      end

      def handle_error(error)
        case error
        when Faraday::ClientError
          case error.response[:status]
          when 400
            raise BadRequestError, error.response
          when 401
            raise UnauthorizedError, error.response
          when 403
            raise ForbiddenError, error.response
          when 404
            raise NotFoundError, error.response
          when 409
            raise ConflictError, error.response
          when 422
            raise UnprocessableEntityError, error.response
          when 429
            raise RateLimitError, error.response
          else
            raise ApiError, error.response
          end
        when Faraday::ServerError
          raise ServerError, error.response
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

      def validate_id!(id, prefix)
        return if id.is_a?(String) && id.start_with?(prefix)

        raise ValidationError, "Invalid ID format. Expected #{prefix}*, got: #{id}"
      end

      def validate_params!(params, required_keys = [], optional_keys = [])
        # Check for required keys
        missing_keys = required_keys - params.keys
        raise ValidationError, "Missing required parameters: #{missing_keys.join(", ")}" if missing_keys.any?

        # Check for unexpected keys
        allowed_keys = required_keys + optional_keys
        unexpected_keys = params.keys - allowed_keys
        return unless unexpected_keys.any?

        raise ValidationError, "Unexpected parameters: #{unexpected_keys.join(", ")}"
      end

      def validate_enum!(value, allowed_values, field_name)
        return if allowed_values.include?(value)

        raise ValidationError, "Invalid #{field_name}. Expected one of: #{allowed_values.join(", ")}, got: #{value}"
      end

      def validate_array!(value, field_name, allowed_values = nil)
        raise ValidationError, "#{field_name} must be an array, got: #{value.class}" unless value.is_a?(Array)

        return unless allowed_values && (invalid_values = value - allowed_values).any?

        raise ValidationError, "Invalid #{field_name} values: #{invalid_values.join(", ")}"
      end

      def validate_timestamp!(value, field_name)
        Time.parse(value.to_s)
      rescue ArgumentError
        raise ValidationError, "Invalid timestamp format for #{field_name}: #{value}"
      end

      def validate_boolean!(value, field_name)
        return if [true, false].include?(value)

        raise ValidationError, "#{field_name} must be a boolean, got: #{value}"
      end

      def validate_integer!(value, field_name, min: nil, max: nil)
        raise ValidationError, "#{field_name} must be an integer, got: #{value.class}" unless value.is_a?(Integer)

        raise ValidationError, "#{field_name} must be greater than or equal to #{min}" if min && value < min

        return unless max && value > max

        raise ValidationError, "#{field_name} must be less than or equal to #{max}"
      end

      def validate_string!(value, field_name, pattern: nil, min_length: nil, max_length: nil)
        raise ValidationError, "#{field_name} must be a string, got: #{value.class}" unless value.is_a?(String)

        raise ValidationError, "#{field_name} format is invalid" if pattern && !value.match?(pattern)

        if min_length && value.length < min_length
          raise ValidationError, "#{field_name} must be at least #{min_length} characters"
        end

        return unless max_length && value.length > max_length

        raise ValidationError, "#{field_name} must be at most #{max_length} characters"
      end

      def validate_url!(value, field_name)
        uri = URI.parse(value)
        unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
          raise ValidationError,
            "Invalid URL format for #{field_name}"
        end
      rescue URI::InvalidURIError
        raise ValidationError, "Invalid URL format for #{field_name}"
      end

      def format_timestamp(value)
        return nil if value.nil?

        value.is_a?(Time) ? value.iso8601 : value
      end
    end
  end
end
