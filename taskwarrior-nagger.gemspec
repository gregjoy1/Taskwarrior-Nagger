# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "taskwarrior-nagger"
  s.version     = 1
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Greg Joy"]
  s.email       = ["gregjoy91@gmail.com"]
  s.homepage    = "http://github.com/gregjoy1/taskwarrior-nagger"
  s.summary     = %q{System which leverages Taskwarrior tasks and nags users to complete them.}
  s.description = %q{This gem leverages Taskwarrior cli and nags users to complete tasks.}
  s.license = 'MIT'

  s.rubyforge_project = "taskwarrior-nagger"

  s.required_ruby_version = '>= 2.2.5'

  s.add_dependency('parseconfig')
  s.add_dependency('rinku')
  s.add_dependency('versionomy')
  s.add_dependency('activesupport', '~> 3')
  s.add_dependency('json', '~> 1.8')
  s.add_dependency('twilio-ruby', '~> 4.11.1')
  s.add_dependency('dotenv', '~> 2.2.0')
  s.add_dependency('tux', '~> 0.3.0')
  s.add_dependency('pry')

  s.add_development_dependency('rake')
  s.add_development_dependency('rspec')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
