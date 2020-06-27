require_relative "lib/view_component/version"

Gem::Specification.new do |spec|
  spec.name          = "view_component"
  spec.version       = ViewComponent::VERSION
  spec.authors       = ["Marcos Minond"]
  spec.email         = ["minond.marcos@gmail.com"]

  spec.summary       = "View components for your Ruby applications."
  spec.description   = "View components for your Ruby applications."
  spec.homepage      = "https://github.com/minond/ruby-view_component"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/minond/ruby-view_component"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "actionview"
  spec.add_development_dependency "activesupport"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
end
