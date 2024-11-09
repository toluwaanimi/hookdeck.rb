module Hookdeck
  module Resources
    class Source < Base
      # List all sources
      def list(params = {})
        get("sources", params)
      end

      # Retrieve a single source
      # @param [String] id Source ID
      def retrieve(id)
        get("sources/#{id}")
      end

      # Create a new source
      def create(params)
        post("sources", params)
      end

      # Upsert (create or update) a source
      def upsert(params)
        put("sources", params)
      end

      # Update a source
      def update(id, params)
        put("sources/#{id}", params)
      end

      # Disable a source
      # @param [String] id Source ID
      def disable(id)
        put("sources/#{id}/disable")
      end

      # Enable a source
      # @param [String] id Source ID
      def enable(id)
        put("sources/#{id}/enable")
      end

      # Delete a source
      # @param [String] id Source ID
      def delete(id)
        delete("sources/#{id}")
      end
    end
  end
end
