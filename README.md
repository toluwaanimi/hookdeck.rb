# Hookdeck Ruby SDK

The unofficial Ruby library for the [Hookdeck API](https://hookdeck.com?ref=github-toluwaanimi-ruby-sdk).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hookdeck'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install hookdeck
```

## Usage

### Configuration

```ruby
require 'hookdeck'

# Configure the client globally
Hookdeck.configure do |config|
  config.api_key = 'your_api_key'
  config.api_version = '2024-09-01' # Optional, defaults to latest version
end

# Or initialize a client instance
client = Hookdeck.new('your_api_key', api_version: '2024-09-01')
```

### Sources

```ruby
# List sources
sources = client.sources.list(limit: 10)

# Create a source
source = client.sources.create(
  name: 'My Webhook Source',
  url: 'https://api.example.com/webhooks'
)

# Retrieve a source
source = client.sources.retrieve('src_123')

# Update a source
source = client.sources.update('src_123',
                               name: 'Updated Source Name'
)

# Disable a source
client.sources.disable('src_123')

# Enable a source
client.sources.enable('src_123')

# Delete a source
client.sources.delete('src_123')
```

### Destinations

```ruby
# List destinations
destinations = client.destinations.list(limit: 10)

# Create a destination
destination = client.destinations.create(
  name: 'My API Endpoint',
  url: 'https://api.example.com/webhooks',
  http_method: 'POST',
  headers: {
    'Authorization': 'Bearer token'
  }
)

# Retrieve a destination
destination = client.destinations.retrieve('dst_123')

# Update a destination
destination = client.destinations.update('dst_123',
                                         headers: { 'X-Custom-Header': 'value' }
)

# Delete a destination
client.destinations.delete('dst_123')
```

### Connections

```ruby
# List connections
connections = client.connections.list(limit: 10)

# Create a connection
connection = client.connections.create(
  source_id: 'src_123',
  destination_id: 'dst_456',
  retry_rule_id: 'rr_789'
)

# Retrieve a connection
connection = client.connections.retrieve('conn_123')

# Update a connection
connection = client.connections.update('conn_123',
                                       ruleset: {
                                         rules: [
                                           {
                                             type: 'filter',
                                             config: {
                                               condition: 'event.type == "order.created"'
                                             }
                                           }
                                         ]
                                       }
)

# Delete a connection
client.connections.delete('conn_123')
```

### Events

```ruby
# List events
events = client.events.list(
  source_id: 'src_123',
  status: 'failed',
  created_at: {
    gte: '2024-01-01T00:00:00Z'
  }
)

# Retrieve an event
event = client.events.retrieve('evt_123')

# Retry an event
client.events.retry('evt_123')

# Mute an event
client.events.mute('evt_123')
```

### Transformations

```ruby
# List transformations
transformations = client.transformations.list(limit: 10)

# Create a transformation
transformation = client.transformations.create(
  name: 'Add Timestamp',
  code: 'event.data.timestamp = Date.now(); return event;'
)

# Retrieve a transformation
transformation = client.transformations.retrieve('tr_123')

# Update a transformation
transformation = client.transformations.update('tr_123',
                                               code: 'return { ...event, modified: true };'
)

# Run a transformation
result = client.transformations.run(
  code: 'return { ...event, processed: true };',
  event: { data: { type: 'test' } }
)

# Delete a transformation
client.transformations.delete('tr_123')
```

### Issue Triggers

```ruby
# List issue triggers
triggers = client.issue_triggers.list(limit: 10)

# Create an issue trigger
trigger = client.issue_triggers.create(
  name: 'High Error Rate',
  type: 'error_rate',
  config: {
    threshold: 0.1,
    window: '15m'
  }
)

# Retrieve an issue trigger
trigger = client.issue_triggers.retrieve('trig_123')

# Update an issue trigger
trigger = client.issue_triggers.update('trig_123',
                                       config: { threshold: 0.05 }
)

# Delete an issue trigger
client.issue_triggers.delete('trig_123')
```

## Error Handling

```ruby

begin
  client.sources.retrieve('invalid_id')
rescue Hookdeck::NotFoundError => e
  puts "Resource not found: #{e.message}"
rescue Hookdeck::ValidationError => e
  puts "Invalid parameters: #{e.message}"
rescue Hookdeck::ApiError => e
  puts "API error: #{e.message}"
  puts "Status: #{e.status}"
  puts "Request ID: #{e.request_id}"
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can
also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/toluwaanimi/hookdeck.rb. This project is
intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to
the [code of conduct](https://github.com/toluwaanimi/hookdeck.rb/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Hookdeck Ruby SDK project's codebases, issue trackers, chat rooms and mailing lists is
expected to follow the [code of conduct](https://github.com/toluwaanimi/hookdeck.rb/blob/main/CODE_OF_CONDUCT.md).
