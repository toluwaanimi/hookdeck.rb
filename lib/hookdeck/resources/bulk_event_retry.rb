module Hookdeck
  module Resources
    class BulkEventRetry < Base
      # List all pending bulk retries
      def list(params = {})
        get("bulk/events/retry", params)
      end

      # Retrieve a single bulk retry
      # @param [String] id Bulk retry ID
      def retrieve(id)
        validate_id!(id, "bulkr_")
        get("bulk/events/retry/#{id}")
      end

      # Cancel a pending bulk retry
      # @param [String] id Bulk retry ID
      def cancel(id)
        validate_id!(id, "blkr_")
        post("bulk/events/retry/#{id}/cancel")
      end

      # Create a new bulk retry
      # @param [Hash] params Bulk retry attributes
      # @option params [Array<String>] :event_ids Event IDs to retry
      # @option params [Hash] :config Override default retry configuration
      def create(params)
        post("bulk/events/retry", params)
      end

      # Get the plan for a bulk retry
      # @param [Hash] params Bulk retry planning parameters
      # @option params [Array<String>] :event_ids Event IDs to plan for
      # @option params [Hash] :config Override default retry configuration
      def plan(params)
        get("bulk/events/retry/plan", params)
      end
    end
  end
end
