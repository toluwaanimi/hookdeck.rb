module Hookdeck
  class Configuration
    DEFAULTS = {
      api_base: "https://api.hookdeck.com",
      api_version: "2024-09-01"
    }.freeze

    attr_accessor :api_key, :api_base, :api_version

    def initialize
      DEFAULTS.each do |key, value|
        instance_variable_set(:"@#{key}", value)
      end
    end

    # Validates the configuration.
    #
    # @raise [Hookdeck::ValidationError] If the API key is not provided.
    def validate!
      validate_api_version!
    end

    private

    def validate_api_version!
      return if api_version.match?(/^\d{4}-\d{2}-\d{2}$/)

      raise ValidationError, "Invalid API version format. Expected YYYY-MM-DD, got #{api_version}"
    end
  end
end
