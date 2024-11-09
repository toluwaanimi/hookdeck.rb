# frozen_string_literal: true

require_relative "lib/hookdeck/version"

Gem::Specification.new do |spec|
  spec.name = "hookdeck"
  spec.version = Hookdeck::VERSION
  spec.authors = ["Emmanuel ADEBAYO"]
  spec.email = ["emmanueltolu.adebayo@gmail.com"]

  spec.summary = "Ruby library for the Hookdeck API"
  spec.description = 'A Ruby toolkit for building and using Hookdeck webhooks. Manage webhook sources,
                       destinations, connections, events, and more.'
  spec.homepage = "https://github.com/toluwaanimi/hookdeck.rb"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/toluwaanimi/hookdeck.rb"
  spec.metadata["changelog_uri"] = "https://github.com/toluwaanimi/hookdeck.rb/blob/main/CHANGELOG.md"
  spec.metadata["documentation_uri"] = "https://github.com/toluwaanimi/hookdeck.rb/blob/main/README.md"
  spec.metadata["bug_tracker_uri"] = "https://github.com/toluwaanimi/hookdeck.rb/issues"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Runtime dependencies
  spec.add_dependency "faraday", "~> 1.0"
  spec.add_dependency "faraday_middleware", "~> 1.2"
  spec.add_dependency "json", "~> 2.0"

  # Development dependencies
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "minitest", "~> 5.16"
  spec.add_development_dependency "pry", "~> 0.14"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rubocop", "~> 1.0"
  spec.add_development_dependency "rubocop-performance", "~> 1.0"
  spec.add_development_dependency "rubocop-rspec", "~> 2.0"
  spec.add_development_dependency "standard", "~> 1.3"
  spec.add_development_dependency "yard", "~> 0.9"
  spec.metadata["rubygems_mfa_required"] = "true"
end
