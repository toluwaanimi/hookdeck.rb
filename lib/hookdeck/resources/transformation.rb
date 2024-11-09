module Hookdeck
  module Resources
    class Transformation < Base
      # List all transformations
      def list(params = {})
        get("transformations", params)
      end

      # Retrieve a single transformation
      # @param [String] id Transformation ID
      def retrieve(id)
        get("transformations/#{id}")
      end

      # Create a new transformation
      def create(params)
        post("transformations", params)
      end

      # Update a transformation
      def update(id, params)
        put("transformations/#{id}", params)
      end

      # Upsert (create or update) a transformation
      def upsert(params)
        put("transformations", params)
      end

      # Run a transformation
      def run(params)
        put("transformations/run", params)
      end

      # List executions for a transformation
      def list_executions(id, params = {})
        get("transformations/#{id}/executions", params)
      end

      # Get a specific execution
      # @param [String] id Transformation ID
      # @param [String] execution_id Execution ID
      def retrieve_execution(id, execution_id)
        get("transformations/#{id}/executions/#{execution_id}")
      end

      # Delete a transformation
      # @param [String] id Transformation ID
      def delete(id)
        delete("transformations/#{id}")
      end
    end
  end
end
