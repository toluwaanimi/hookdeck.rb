module Hookdeck
  module Resources
    class BulkRequestsRetry < Base
      # Cancel a pending bulk requests retry
      def cancel_retry(id)
        post("bulk/requests/retry/#{id}/cancel")
      end

      # Get the plan for a bulk requests retry
      def plan_retry(params)
        get("bulk/requests/retry/plan", params)
      end

      # List all pending bulk requests retries
      def list_retries(params = {})
        get("bulk/requests/retry", params)
      end

      # Retrieve a single bulk requests retry
      # @param [String] id Bulk requests retry ID
      def retrieve_retry(id)
        get("bulk/requests/retry/#{id}")
      end

      # Create a new bulk requests retry
      def create_retry(params)
        post("bulk/requests/retry", params)
      end
    end
  end
end
