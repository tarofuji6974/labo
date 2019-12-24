# -*- encoding: utf-8 -*-
# stub: carender 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "carender".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["kami-zh".freeze]
  s.date = "2018-01-19"
  s.description = "A monthly calendar for Rails application.".freeze
  s.email = ["hiroki.zenigami@gmail.com".freeze]
  s.homepage = "https://github.com/kami-zh/carender".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.1".freeze
  s.summary = "A monthly calendar for Rails application.".freeze

  s.installed_by_version = "3.0.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 0"])
      s.add_development_dependency(%q<actionview>.freeze, [">= 0"])
      s.add_development_dependency(%q<oga>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<activesupport>.freeze, [">= 0"])
      s.add_dependency(%q<actionview>.freeze, [">= 0"])
      s.add_dependency(%q<oga>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 0"])
    s.add_dependency(%q<actionview>.freeze, [">= 0"])
    s.add_dependency(%q<oga>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
