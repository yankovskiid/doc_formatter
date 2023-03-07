# frozen_string_literal: true

require_relative "lib/doc_formatter/version"

Gem::Specification.new do |spec|
  spec.name = "doc_formatter"
  spec.version = DocFormatter::VERSION
  spec.authors = ["Dmitry Yankovski"]
  spec.email = ["yankovskiidv@gmail.com"]

  spec.summary = "Gem for formatting DOCX to XLSX"
  spec.description = "TBD"
  spec.homepage = "TBD"
  spec.required_ruby_version = "~> 3.1.2"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "TBD"
  spec.metadata["changelog_uri"] = "TBD"

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
