module Hookdeck
  module Resources
    class IssueTrigger < Base
      # List all issue triggers
      def list(params = {})
        get("issue-triggers", params)
      end

      # Retrieve a single issue trigger
      # @param [String] id Issue trigger ID
      def retrieve(id)
        get("issue-triggers/#{id}")
      end

      # Create a new issue trigger
      def create(params)
        post("issue-triggers", params)
      end

      # Update an issue trigger
      def update(id, params)
        put("issue-triggers/#{id}", params)
      end

      # Upsert (create or update) an issue trigger
      def upsert(params)
        put("issue-triggers", params)
      end

      # Trigger an issue manually
      # @param [String] id Issue trigger ID
      # @param [Hash] params Optional trigger parameters
      def trigger(id, params = {})
        post("issue-triggers/#{id}", params)
      end

      # Disable an issue trigger
      # @param [String] id Issue trigger ID
      def disable(id)
        put("issue-triggers/#{id}/disable")
      end

      # Enable an issue trigger
      # @param [String] id Issue trigger ID
      def enable(id)
        put("issue-triggers/#{id}/enable")
      end

      # Delete an issue trigger
      # @param [String] id Issue trigger ID
      def delete(id)
        delete("issue-triggers/#{id}")
      end
    end
  end
end
