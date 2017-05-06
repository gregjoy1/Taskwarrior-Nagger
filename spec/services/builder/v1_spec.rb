require File.dirname(__FILE__) + '/../../spec_helper'
require 'taskwarrior-nagger/services/builder/v1'
require 'taskwarrior-nagger/model/command'
require 'ostruct'

describe TaskwarriorNagger::CommandBuilder::V1 do
  describe '#substitute_parts' do
    before do
      TaskwarriorNagger::Command.class_eval do |class_name|
        include TaskwarriorNagger::CommandBuilder::V1
      end
      @command = TaskwarriorNagger::Command.new(:complete, 34588)
    end

    it 'should replace the :id string with the given task ID' do
      TaskwarriorNagger::Task.should_receive(:query).and_return([OpenStruct.new(:uuid => 34588)])
      @command.task_command.substitute_parts.command_string.should eq('1 done')
    end

    it 'should throw an error if there is no id' do
      command = TaskwarriorNagger::Command.new(:complete)
      expect { command.substitute_parts }.to raise_error(TaskwarriorNagger::CommandBuilder::MissingTaskIDError)
    end
  end
end
