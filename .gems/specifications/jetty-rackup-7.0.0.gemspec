# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{jetty-rackup}
  s.version = "7.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Vladimir Dobriakov}, %q{Leandro Silva}, %q{Jason Rogers}]
  s.date = %q{2012-01-01}
  s.description = %q{Runs a rack conform application inside jetty web server}
  s.email = %q{vladimir@geekq.net}
  s.executables = [%q{jetty-rackup}]
  s.extra_rdoc_files = [%q{LICENSE}, %q{README.markdown}]
  s.files = [%q{bin/jetty-rackup}, %q{LICENSE}, %q{README.markdown}]
  s.homepage = %q{http://github.com/geekq/jetty-rackup}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.9}
  s.summary = %q{Rack + Jetty = Retty}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
