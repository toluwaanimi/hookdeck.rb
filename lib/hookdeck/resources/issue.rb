module Hookdeck
  module Resources
    class Issue < Base
      # List all issues
      def list(params = {})
        get("issues", params)
      end

      # Retrieve a single issue
      # @param [String] id Issue ID
      def retrieve(id)
        get("issues/#{id}")
      end

      # Create a new issue
      def create(params)
        post("issues", params)
      end

      # Update an existing issue
      def update(id, params)
        put("issues/#{id}", params)
      end

      # Delete an issue
      # @param [String] id Issue ID
      def delete(id)
        delete("issues/#{id}")
      end
    end
  end
end
