# -*- encoding: utf-8 -*-
# stub: resources_id_replace 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "resources_id_replace".freeze
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Toru KAWAMURA".freeze]
  s.date = "2012-11-29"
  s.description = "Replace param name of resources' id".freeze
  s.email = ["tkawa@4bit.net".freeze]
  s.homepage = "https://github.com/tkawa/resources_id_replace".freeze
  s.rubygems_version = "3.0.1".freeze
  s.summary = "Replace param name of resources' id".freeze

  s.installed_by_version = "3.0.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>.freeze, [">= 3.0.0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<actionpack>.freeze, [">= 3.0.0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<actionpack>.freeze, [">= 3.0.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
