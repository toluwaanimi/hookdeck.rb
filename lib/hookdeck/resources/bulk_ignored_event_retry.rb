module Hookdeck
  module Resources
    class BulkIgnoredEventsRetry < Base
      # Cancel a pending bulk ignored events retry
      def cancel_retry(id)
        post("bulk/ignored-events/retry/#{id}/cancel")
      end

      # Get the plan for a bulk ignored events retry
      def plan_retry(params)
        get("bulk/ignored-events/retry/plan", params)
      end

      # List all pending bulk ignored events retries
      def list_retries(params = {})
        get("bulk/ignored-events/retry", params)
      end

      # Retrieve a single bulk ignored events retry
      # @param [String] id Bulk ignored events retry ID
      def retrieve_retry(id)
        get("bulk/ignored-events/retry/#{id}")
      end

      # Create a new bulk ignored events retry
      def create_retry(params)
        post("bulk/ignored-events/retry", params)
      end

      # Cancel a bulk of ignored events
      def cancel_ignored_events(id)
        post("bulk/ignored-events/#{id}/cancel")
      end
    end
  end
end
