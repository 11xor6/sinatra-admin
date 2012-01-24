# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{trinidad}
  s.version = "1.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{David Calavera}]
  s.date = %q{2012-01-06}
  s.description = %q{Trinidad allows you to run a rails or rackup applications within an embedded Apache Tomcat container}
  s.email = %q{calavera@apache.org}
  s.executables = [%q{trinidad}]
  s.extra_rdoc_files = [%q{README.md}, %q{LICENSE}]
  s.files = [%q{bin/trinidad}, %q{README.md}, %q{LICENSE}]
  s.homepage = %q{http://github.com/calavera/trinidad}
  s.rdoc_options = [%q{--charset=UTF-8}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{trinidad}
  s.rubygems_version = %q{1.8.9}
  s.summary = %q{Simple library to run rails applications into an embedded Tomcat}

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<trinidad_jars>, [">= 1.0.1"])
      s.add_runtime_dependency(%q<rack>, [">= 0"])
      s.add_runtime_dependency(%q<jruby-rack>, [">= 1.1.2"])
      s.add_development_dependency(%q<rspec>, ["~> 2.5.0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<fakefs>, [">= 0.4.0"])
    else
      s.add_dependency(%q<trinidad_jars>, [">= 1.0.1"])
      s.add_dependency(%q<rack>, [">= 0"])
      s.add_dependency(%q<jruby-rack>, [">= 1.1.2"])
      s.add_dependency(%q<rspec>, ["~> 2.5.0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<fakefs>, [">= 0.4.0"])
    end
  else
    s.add_dependency(%q<trinidad_jars>, [">= 1.0.1"])
    s.add_dependency(%q<rack>, [">= 0"])
    s.add_dependency(%q<jruby-rack>, [">= 1.1.2"])
    s.add_dependency(%q<rspec>, ["~> 2.5.0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<fakefs>, [">= 0.4.0"])
  end
end
