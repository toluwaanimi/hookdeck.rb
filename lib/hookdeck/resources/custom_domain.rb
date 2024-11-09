module Hookdeck
  module Resources
    class CustomDomain < Base
      def list(params = {})
        get("teams/current/custom_domains", params)
      end

      def create(params = {})
        post("teams/current/custom_domains", params)
      end

      def delete(id)
        delete("teams/current/custom_domains/#{id}")
      end
    end
  end
end
