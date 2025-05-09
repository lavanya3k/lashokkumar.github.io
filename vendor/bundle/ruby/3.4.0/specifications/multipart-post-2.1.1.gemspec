# -*- encoding: utf-8 -*-
# stub: multipart-post 2.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "multipart-post".freeze
  s.version = "2.1.1".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nick Sieger".freeze, "Samuel Williams".freeze]
  s.date = "2019-05-13"
  s.description = "Use with Net::HTTP to do multipart form postspec. IO values that have #content_type, #original_filename, and #local_path will be posted as a binary file.".freeze
  s.email = ["nick@nicksieger.com".freeze, "samuel.williams@oriontransfer.co.nz".freeze]
  s.homepage = "https://github.com/nicksieger/multipart-post".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "A multipart form post accessory for Net::HTTP.".freeze

  s.installed_by_version = "3.6.8".freeze

  s.specification_version = 4

  s.add_development_dependency(%q<bundler>.freeze, [">= 1.3".freeze, "< 3".freeze])
  s.add_development_dependency(%q<rspec>.freeze, ["~> 3.4".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
end
