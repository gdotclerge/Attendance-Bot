# -*- encoding: utf-8 -*-
# stub: dokku-cli 0.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "dokku-cli".freeze
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Sebastian Szturo".freeze]
  s.date = "2018-01-16"
  s.description = "Command line tool for Dokku.".freeze
  s.email = ["s.szturo@me.com".freeze]
  s.executables = ["dokku".freeze]
  s.files = ["bin/dokku".freeze]
  s.homepage = "http://github.com/SebastianSzturo/dokku-cli".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.7".freeze
  s.summary = "Command line tool for Dokku.".freeze

  s.installed_by_version = "2.7.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<thor>.freeze, ["~> 0.19"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.7"])
    else
      s.add_dependency(%q<thor>.freeze, ["~> 0.19"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
    end
  else
    s.add_dependency(%q<thor>.freeze, ["~> 0.19"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
  end
end
