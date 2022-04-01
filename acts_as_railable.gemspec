require_relative "lib/acts_as_railable/version"

Gem::Specification.new do |spec|
  spec.name        = "acts_as_railable"
  spec.version     = ActsAsRailable::VERSION
  spec.authors     = ["Li Qi"]
  spec.email       = ["cloudbsd@qq.com"]
  spec.homepage    = "http://github.com/cloudbsd/acts_as_moonable"
  spec.summary     = "Acts As Moonable Gem."
  spec.description = "ActsAsMoonable gem provides extended methods for rails."
  spec.license     = "BSD"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://github.com/cloudbsd/acts_as_moonable"
  spec.metadata["changelog_uri"] = "http://github.com/cloudbsd/acts_as_moonable/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency 'rails', ">= 5.2"
# spec.add_dependency "rails", ">= 7.0.2.3"
end
