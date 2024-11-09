module Hookdeck
  module Resources
    class Notification < Base
      # Configure webhook notifications for the project
      def configure_webhooks(params)
        validate_webhook_params!(params)
        put("notifications/webhooks", params)
      end

      private

      def validate_webhook_params!(params)
        required_keys = %i[enabled topics source_id]
        validate_params!(params, required_keys)

        # Validate enabled is boolean
        validate_boolean!(params[:enabled], "enabled")

        # Validate topics is array of strings
        validate_array!(params[:topics], "topics")
        params[:topics].each do |topic|
          validate_string!(topic, "topic")
        end

        # Validate source_id format
        validate_id!(params[:source_id], "src_")
      end
    end
  end
end
