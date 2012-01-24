# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ratpack}
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Zeke Sikelianos}]
  s.date = %q{2009-10-29}
  s.description = %q{link_to, content_tag, stylesheet_link_tag, javascript_include_tag, etc}
  s.email = %q{zeke@sikelianos.com}
  s.extra_rdoc_files = [%q{LICENSE}, %q{README.rdoc}]
  s.files = [%q{LICENSE}, %q{README.rdoc}]
  s.homepage = %q{http://github.com/zeke/ratpack}
  s.rdoc_options = [%q{--charset=UTF-8}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.9}
  s.summary = %q{A set of view helpers for Sinatra. Inspired by Rails' ActionView helpers}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 1.0.0"])
      s.add_runtime_dependency(%q<sinatra>, [">= 0.9.1"])
      s.add_development_dependency(%q<rack-test>, [">= 0.3.0"])
    else
      s.add_dependency(%q<rack>, [">= 1.0.0"])
      s.add_dependency(%q<sinatra>, [">= 0.9.1"])
      s.add_dependency(%q<rack-test>, [">= 0.3.0"])
    end
  else
    s.add_dependency(%q<rack>, [">= 1.0.0"])
    s.add_dependency(%q<sinatra>, [">= 0.9.1"])
    s.add_dependency(%q<rack-test>, [">= 0.3.0"])
  end
end
