require "bundler/setup"
require "view_component"

require_relative "test_components"

ViewComponent::Injector.inject_rails_helpers_into_view_component!

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
