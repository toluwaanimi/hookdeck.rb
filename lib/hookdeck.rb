require "forwardable"
require "faraday"
require "faraday_middleware"
require "json"
require "logger"
require "uri"

require_relative "hookdeck/version"
require_relative "hookdeck/errors"
require_relative "hookdeck/configuration"
require_relative "hookdeck/client"
require_relative "hookdeck/http_client"
require_relative "hookdeck/resources"

module Hookdeck
  autoload :VERSION, "hookdeck/version"
  autoload :Configuration, "hookdeck/configuration"
  autoload :Client, "hookdeck/client"
  autoload :Resources, "hookdeck/resources"
  autoload :Error, "hookdeck/errors"

  class << self
    def new(api_key = nil, options = {})
      Client.new(api_key, options)
    end

    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def reset!
      @configuration = nil
    end
  end
end
