# -*- encoding: utf-8 -*-
# stub: activesupport 4.2.11.1 ruby lib

Gem::Specification.new do |s|
  s.name = "activesupport".freeze
  s.version = "4.2.11.1".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["David Heinemeier Hansson".freeze]
  s.date = "2019-03-11"
  s.description = "A toolkit of support libraries and Ruby core extensions extracted from the Rails framework. Rich support for multibyte strings, internationalization, time zones, and testing.".freeze
  s.email = "david@loudthinking.com".freeze
  s.homepage = "http://www.rubyonrails.org".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--encoding".freeze, "UTF-8".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "3.0.1".freeze
  s.summary = "A toolkit of support libraries and Ruby core extensions extracted from the Rails framework.".freeze

  s.installed_by_version = "3.6.8".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<i18n>.freeze, ["~> 0.7".freeze])
  s.add_runtime_dependency(%q<tzinfo>.freeze, ["~> 1.1".freeze])
  s.add_runtime_dependency(%q<minitest>.freeze, ["~> 5.1".freeze])
  s.add_runtime_dependency(%q<thread_safe>.freeze, ["~> 0.3".freeze, ">= 0.3.4".freeze])
end
