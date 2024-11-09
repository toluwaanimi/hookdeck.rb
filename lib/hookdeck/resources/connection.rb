# lib/hookdeck/resources/connection.rb
module Hookdeck
  module Resources
    class Connection < Base
      # List all connections
      def list(params = {})
        get("connections", params)
      end

      # Retrieve a single connection
      # @param [String] id Connection ID
      def retrieve(id)
        get("connections/#{id}")
      end

      # Create a new connection
      def create(params)
        post("connections", params)
      end

      # Upsert (create or update) a connection
      def upsert(params)
        put("connections", params)
      end

      # Update a connection
      def update(id, params)
        put("connections/#{id}", params)
      end

      # Disable a connection
      # @param [String] id Connection ID
      def disable(id)
        put("connections/#{id}/disable")
      end

      # Enable a connection
      # @param [String] id Connection ID
      def enable(id)
        put("connections/#{id}/enable")
      end

      # Pause a connection
      # @param [String] id Connection ID
      def pause(id)
        put("connections/#{id}/pause")
      end

      # Unpause a connection
      # @param [String] id Connection ID
      def unpause(id)
        put("connections/#{id}/unpause")
      end

      # Delete a connection
      # @param [String] id Connection ID
      def delete(id)
        delete("connections/#{id}")
      end
    end
  end
end
