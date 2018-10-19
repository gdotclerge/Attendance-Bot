# -*- encoding: utf-8 -*-
# stub: newrelic-slack-ruby-bot 0.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "newrelic-slack-ruby-bot".freeze
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Daniel Doubrovkine".freeze]
  s.date = "2017-11-11"
  s.email = "dblock@dblock.org".freeze
  s.homepage = "http://github.com/slack-ruby/newrelic-slack-ruby-bot".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.7".freeze
  s.summary = "NewRelic instrumentation for slack-ruby-bot.".freeze

  s.installed_by_version = "2.7.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<newrelic_rpm>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<slack-ruby-bot>.freeze, [">= 0.10.5"])
    else
      s.add_dependency(%q<newrelic_rpm>.freeze, [">= 0"])
      s.add_dependency(%q<slack-ruby-bot>.freeze, [">= 0.10.5"])
    end
  else
    s.add_dependency(%q<newrelic_rpm>.freeze, [">= 0"])
    s.add_dependency(%q<slack-ruby-bot>.freeze, [">= 0.10.5"])
  end
end
