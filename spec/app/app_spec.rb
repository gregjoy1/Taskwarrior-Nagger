require File.dirname(__FILE__) + '/../spec_helper'
require 'taskwarrior-nagger'

set :environment, :test

describe TaskwarriorNagger::App do
  include Rack::Test::Methods

  def app
    TaskwarriorNagger::App
  end
end
