# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{trinidad_jars}
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{David Calavera}]
  s.date = %q{2011-12-31}
  s.description = %q{Bundled version of Tomcat packed for Trinidad}
  s.email = %q{calavera@apache.org}
  s.homepage = %q{http://github.com/calavera/trinidad}
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{trinidad_jars}
  s.rubygems_version = %q{1.8.9}
  s.summary = %q{Tomcat's jars packed for Trinidad}

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
