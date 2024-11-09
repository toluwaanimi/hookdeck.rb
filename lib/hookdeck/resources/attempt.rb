module Hookdeck
  module Resources
    # @example List recent attempts
    #   client.attempts.list(limit: 10)
    #
    # @example Retrieve specific attempt
    #   attempt = client.attempts.retrieve('atm_123')
    #
    class Attempt < Base
      def list(params = {})
        get("attempts", params)
      end

      # Retrieves an attempt by ID.
      #
      # @param id [String] The ID of the attempt.
      # @return [Hash] The attempt.
      def retrieve(id)
        validate_id!(id, "atm_")
        get("attempts/#{id}")
      end
    end
  end
end
