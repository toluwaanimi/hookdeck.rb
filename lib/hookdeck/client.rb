module Hookdeck
  class Client
    extend Forwardable

    attr_reader :config, :http_client

    def initialize(api_key = nil, options = {})
      @config = build_config(api_key, options)
      @http_client = HttpClient.new(@config)
      initialize_resources
    end

    # Sends a request to the Hookdeck API.
    #
    # @param method [String] The HTTP method.
    # @param path [String] The path.
    # @param params [Hash] The parameters.
    # @param opts [Hash] The options.
    # @return [Hash] The response.
    def request(method, path, params = {}, opts = {})
      response = http_client.connection.public_send(method) do |req|
        req.url(path)
        req.params = params if params.any?
        req.body = opts[:body].to_json if opts[:body]
        req.headers.merge!(opts[:headers] || {})
      end

      response.body
    end

    # Accessor for the Attempt resource.
    #
    # @return [Hookdeck::Resources::Attempt] The Attempt resource.
    def attempts
      @attempts ||= Hookdeck::Resources::Attempt.new(self)
    end

    # Accessor for the Bookmark resource.
    #
    # @return [Hookdeck::Resources::Bookmark] The Bookmark resource.
    def bookmarks
      @bookmarks ||= Hookdeck::Resources::Bookmark.new(self)
    end

    # Accessor for the Connection resource.
    #
    # @return [Hookdeck::Resources::Connection] The Connection resource.
    def connections
      @connections ||= Hookdeck::Resources::Connection.new(self)
    end

    # Accessor for the Event resource.
    #
    # @return [Hookdeck::Resources::Event] The Event resource.
    def events
      @events ||= Hookdeck::Resources::Event.new(self)
    end

    # Accessor for the Notification resource.
    #
    # @return [Hookdeck::Resources::Notification] The Notification resource.
    def notifications
      @notifications ||= Hookdeck::Resources::Notification.new(self)
    end

    # Accessor for the Source resource.
    #
    # @return [Hookdeck::Resources::Source] The Source resource.
    def sources
      @sources ||= Hookdeck::Resources::Source.new(self)
    end

    # Accessor for the Destination resource.
    #
    # @return [Hookdeck::Resources::Destination] The Destination resource.
    def destinations
      @destinations ||= Hookdeck::Resources::Destination.new(self)
    end

    # Accessor for the Issue resource.
    #
    # @return [Hookdeck::Resources::Issue] The Issue resource.
    def issues
      @issues ||= Hookdeck::Resources::Issue.new(self)
    end

    # Accessor for the IssueTrigger resource.
    #
    # @return [Hookdeck::Resources::IssueTrigger] The IssueTrigger resource.
    def issue_triggers
      @issue_triggers ||= Hookdeck::Resources::IssueTrigger.new(self)
    end

    # Accessor for the CustomDomain resource.
    #
    # @return [Hookdeck::Resources::CustomDomain] The CustomDomain resource.
    def custom_domains
      @custom_domains ||= Hookdeck::Resources::CustomDomain.new(self)
    end

    # Accessor for the Request resource.
    #
    # @return [Hookdeck::Resources::Request] The Request resource.
    def requests
      @requests ||= Hookdeck::Resources::Request.new(self)
    end

    # Accessor for the Transformation resource.
    #
    # @return [Hookdeck::Resources::Transformation] The Transformation resource.
    def transformations
      @transformations ||= Hookdeck::Resources::Transformation.new(self)
    end

    # Accessor for the BulkIgnoredEventsRetry resource.
    #
    # @return [Hookdeck::Resources::BulkIgnoredEventsRetry] The BulkIgnoredEventsRetry resource.
    def bulk_ignored_events_retry
      @bulk_ignored_events_retry ||= Hookdeck::Resources::BulkIgnoredEventsRetry.new(self)
    end

    # Accessor for the BulkEventRetry resource.
    #
    # @return [Hookdeck::Resources::BulkEventRetry] The BulkEventRetry resource.
    def bulk_events_retry
      @bulk_events_retry ||= Hookdeck::Resources::BulkEventRetry.new(self)
    end

    # Accessor for the BulkRequestsRetry resource.
    #
    # @return [Hookdeck::Resources::BulkRequestsRetry] The BulkRequestsRetry resource.
    def bulk_requests_retry
      @bulk_requests_retry ||= Hookdeck::Resources::BulkRequestsRetry.new(self)
    end

    private

    # Builds the configuration for the client.
    #
    # @param api_key [String] The API key.
    # @param options [Hash] The options.
    # @return [Hookdeck::Configuration] The configuration.
    def build_config(api_key, options)
      config = Configuration.new
      config.api_key = api_key || HookDeck.configuration.api_key
      options.each do |key, value|
        config.public_send(:"#{key}=", value) if config.respond_to?(:"#{key}=")
      end
      validate_config!(config)
      config
    end

    # Validates the configuration.
    #
    # @param config [Hookdeck::Configuration] The configuration.
    # @raise [Hookdeck::ValidationError] If the API key is not provided.
    def validate_config!(config)
      raise ValidationError, "API key must be provided" if config.api_key.nil?
    end

    # Initializes the resources.
    #
    # Resources are lazy-loaded when accessed
    def initialize_resources
      # Resources are lazy-loaded when accessed
    end
  end
end
