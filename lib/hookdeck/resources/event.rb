module Hookdeck
  module Resources
    class Event < Base
      # List all events
      def list(params = {})
        get("events", params)
      end

      # Retrieve a single event
      # @param [String] id Event ID
      def retrieve(id)
        validate_id!(id, "evt_")
        get("events/#{id}")
      end

      # Retry an event
      def retry(id, params = {})
        validate_id!(id, "evt_")
        post("events/#{id}/retry", params)
      end

      # Mute an event
      def mute(id, params = {})
        validate_id!(id, "evt_")
        put("events/#{id}/mute", params)
      end
    end
  end
end
