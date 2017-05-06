require 'bundler'
require 'rspec/core/rake_task'
require 'dotenv/load'
require 'twilio-ruby'
require 'pry'

require File.expand_path("#{File.dirname(__FILE__)}/lib/taskwarrior-web")

Bundler::GemHelper.install_tasks
RSpec::Core::RakeTask.new(:spec)

desc 'Uninstalls the current version of taskwarrior-web'
task :uninstall do
  `gem uninstall -x taskwarrior-web`
end

desc 'Reloads the gem (useful for local development)'
task :refresh => [:uninstall, :install] do
  `task-web -F`
end

desc 'Send morning text nag'
task :nag_morning do
  nagger = ::TaskwarriorWeb::Nagger::Morning.new

  if nagger.should_run?
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

    @client.account.messages.create({
      to: ENV['TWILIO_MY_NUMBER'],
      from: '441293311518',
      body: nagger.get_message
    })
  end
end

desc 'Send evening text nag'
task :nag_evening do
  nagger = ::TaskwarriorWeb::Nagger::Evening.new

  if nagger.should_run?
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

    @client.account.messages.create({
      to: ENV['TWILIO_MY_NUMBER'],
      from: '441293311518',
      body: nagger.get_message
    })
  end
end
