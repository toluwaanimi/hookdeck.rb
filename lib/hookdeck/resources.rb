module Hookdeck
  module Resources
    autoload :Base, "hookdeck/resources/base"
    autoload :Bookmark, "hookdeck/resources/bookmark"
    autoload :Attempt, "hookdeck/resources/attempt"
    autoload :Connection, "hookdeck/resources/connection"
    autoload :CustomDomain, "hookdeck/resources/custom_domain"
    autoload :Destination, "hookdeck/resources/destination"
    autoload :Event, "hookdeck/resources/event"
    autoload :EventBulkRetry, "hookdeck/resources/event_bulk_retry"
    autoload :IgnoredEventBulkRetry, "hookdeck/resources/ignored_event_bulk_retry"
    autoload :Issue, "hookdeck/resources/issue"
    autoload :IssueTrigger, "hookdeck/resources/issue_trigger"
    autoload :Notification, "hookdeck/resources/notification"
    autoload :Request, "hookdeck/resources/request"
    autoload :RequestBulkRetry, "hookdeck/resources/request_bulk_retry"
    autoload :Source, "hookdeck/resources/source"
    autoload :Transformation, "hookdeck/resources/transformation"
  end
end
