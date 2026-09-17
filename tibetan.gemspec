# frozen_string_literal: true

require_relative "lib/tibetan/version"

Gem::Specification.new do |spec|
  spec.name          = "tibetan"
  spec.version       = Tibetan::VERSION
  spec.authors       = ["rovetz"]
  spec.email         = ["zakbox@gmail.com"]

  spec.summary       = "Romanization (transliteration) of Tibetan"
  spec.description   = "Romanization (transliteration) of Tibetan. Converts Tibetan text to the Roman (Latin) script using THL EWTS (Extended Wylie Transliteration Scheme)"
  spec.homepage      = "https://github.com/rovetz/tibetan"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"]           = spec.homepage
  spec.metadata["source_code_uri"]        = "https://github.com/rovetz/tibetan"
  spec.metadata["changelog_uri"]          = "https://github.com/rovetz/tibetan/blob/main/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"]        = "https://github.com/rovetz/tibetan/issues"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").select { |f| File.file?(f) }.reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github Gemfile])
    end
  end
  spec.bindir        = "exe"
  spec.executables   = ["tibetan"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 2.0"
  spec.add_development_dependency "minitest", ">= 5.16"
  spec.add_development_dependency "rake", ">= 13.0"
end
