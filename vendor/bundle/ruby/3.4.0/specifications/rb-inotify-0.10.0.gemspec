# -*- encoding: utf-8 -*-
# stub: rb-inotify 0.10.0 ruby lib

Gem::Specification.new do |s|
  s.name = "rb-inotify".freeze
  s.version = "0.10.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Natalie Weizenbaum".freeze, "Samuel Williams".freeze]
  s.date = "2018-12-15"
  s.email = ["nex342@gmail.com".freeze, "samuel.williams@oriontransfer.co.nz".freeze]
  s.homepage = "https://github.com/guard/rb-inotify".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2".freeze)
  s.rubygems_version = "2.7.8".freeze
  s.summary = "A Ruby wrapper for Linux inotify, using FFI".freeze

  s.installed_by_version = "3.6.8".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<ffi>.freeze, ["~> 1.0".freeze])
  s.add_development_dependency(%q<rspec>.freeze, ["~> 3.6".freeze])
  s.add_development_dependency(%q<bundler>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<concurrent-ruby>.freeze, [">= 0".freeze])
end
