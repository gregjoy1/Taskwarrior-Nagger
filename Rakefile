require 'bundler'
require 'rspec/core/rake_task'
require 'dotenv/load'
require 'twilio-ruby'
require 'pry'

require File.expand_path("#{File.dirname(__FILE__)}/lib/taskwarrior-nagger")

Bundler::GemHelper.install_tasks
RSpec::Core::RakeTask.new(:spec)

desc 'Send morning text nag'
task :nag_morning do
  nagger = ::TaskwarriorNagger::Nagger::Morning.new

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
  nagger = ::TaskwarriorNagger::Nagger::Evening.new

  if nagger.should_run?
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

    @client.account.messages.create({
      to: ENV['TWILIO_MY_NUMBER'],
      from: '441293311518',
      body: nagger.get_message
    })
  end
end
