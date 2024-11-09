module Hookdeck
  module Resources
    class Request < Base
      # List all requests
      def list(params = {})
        get("requests", params)
      end

      # Retrieve a single request
      # @param [String] id Request ID
      def retrieve(id)
        get("requests/#{id}")
      end

      # Retry a request
      # @param [String] id Request ID
      def retry(id, params = {})
        post("requests/#{id}/retry", params)
      end

      # List events for a request
      # @param [String] id Request ID
      def list_events(id, params = {})
        get("requests/#{id}/events", params)
      end

      # List ignored events for a request
      def list_ignored_events(id, params = {})
        get("requests/#{id}/ignored_events", params)
      end
    end
  end
end
