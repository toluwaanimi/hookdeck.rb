# frozen_string_literal: true

module Hookdeck
  module Resources
    # @example Create a new bookmark
    #   client.bookmarks.create(
    #     label: "Product Update – Out of Stock",
    #     event_data_id: "evtreq_HlJhb39nsjIP0FDsU3SY0fo7",
    #     webhook_id: "web_UfM5ZY2wxLD6sLhDaKMcx5wp"
    #   )
    #
    # @example Trigger a bookmark
    #   client.bookmarks.trigger('bkm_123')
    #
    class Bookmark < Base
      def list(params = {})
        get("bookmarks", params)
      end

      # Retrieves a bookmark by ID.
      #
      # @param id [String] The ID of the bookmark.
      # @return [Hash] The bookmark.
      def retrieve(id)
        validate_id!(id, "bkm_")
        get("bookmarks/#{id}")
      end

      # Creates a bookmark.
      # {
      #   "label": "Product Update – Out of Stock",
      #   "event_data_id": "evtreq_HlJhb39nsjIP0FDsU3SY0fo7",
      #   "webhook_id": "web_UfM5ZY2wxLD6sLhDaKMcx5wp"
      # }
      # @param params [Hash] The parameters.
      # @return [Hash] The bookmark.
      def create(params)
        post("bookmarks", params)
      end

      # Updates a bookmark.
      # @param id [String] The ID of the bookmark.
      # @param params [Hash] The parameters.
      # {
      #   "label": "Product Update – Out of Stock",
      #   "event_data_id": "evtreq_HlJhb39nsjIP0FDsU3SY0fo7",
      #   "webhook_id": "web_UfM5ZY2wxLD6sLhDaKMcx5wp"
      # }
      # @return [Hash] The bookmark.
      def update(id, params)
        validate_id!(id, "bkm_")
        put("bookmarks/#{id}", params)
      end

      # This endpoint uses a bookmark to create events.
      # @param id [String] The ID of the bookmark.
      # @param params [Hash] The parameters.
      # @return [Hash] The bookmark.
      def trigger(id, params = {})
        validate_id!(id, "bkm_")
        post("bookmarks/#{id}/trigger", params)
      end

      def delete(id)
        validate_id!(id, "bkm_")
        delete("bookmarks/#{id}")
      end
    end
  end
end
