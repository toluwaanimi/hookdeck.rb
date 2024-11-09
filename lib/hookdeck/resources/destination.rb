module Hookdeck
  module Resources
    class Destination < Base
      # List all destinations
      def list(params = {})
        get("destinations", params)
      end

      # Retrieve a single destination
      # @param [String] id Destination ID
      def retrieve(id)
        get("destinations/#{id}")
      end

      # Create a new destination
      def create(params)
        post("destinations", params)
      end

      # Upsert (create or update) a destination
      def upsert(params)
        put("destinations", params)
      end

      # Update a destination
      def update(id, params)
        put("destinations/#{id}", params)
      end

      # Disable a destination
      # @param [String] id Destination ID
      def disable(id)
        put("destinations/#{id}/disable")
      end

      # Enable a destination
      # @param [String] id Destination ID
      def enable(id)
        put("destinations/#{id}/enable")
      end

      # Delete a destination
      # @param [String] id Destination ID
      def delete(id)
        delete("destinations/#{id}")
      end
    end
  end
end
