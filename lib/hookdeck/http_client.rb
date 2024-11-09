class HttpClient
  attr_reader :config

  def initialize(config)
    @config = config
    @connection_pools = {}
  end

  def connection
    Thread.current[:hookdeck_client] ||= build_connection
  end

  def build_connection
    Faraday.new(url: config.api_base) do |faraday|
      setup_request_middleware(faraday)
      setup_response_middleware(faraday)
      setup_error_handling(faraday)
      faraday.adapter :net_http
    end
  end

  def setup_request_middleware(faraday)
    faraday.request :json
    # faraday.request :retry, max: config.max_retries, interval: config.retry_interval
    faraday.request :authorization, "Bearer", config.api_key

    # faraday.use Middleware::RequestId, prefix: config.request_id_prefix
    # faraday.use Middleware::Logging, logger: config.logger
  end

  def setup_response_middleware(faraday)
    faraday.response :json, content_type: /\bjson$/
    # faraday.response :logger, config.logger, bodies: true if config.logger
  end

  def setup_error_handling(faraday)
    # faraday.use Middleware::ErrorHandler
  end
end
