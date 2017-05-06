require File.dirname(__FILE__) + '/../spec_helper'
require 'taskwarrior-nagger/model/task'

describe TaskwarriorNagger::Task do
  RSpec::Mocks::setup(TaskwarriorNagger::Runner)
  TaskwarriorNagger::Runner.double(:run) { '{}' }

  describe '#initialize' do
    it 'should assign the passed attributes' do
      task = TaskwarriorNagger::Task.new({:entry => 'Testing', :project => 'Project'})
      task.entry.should eq('Testing')
      task.project.should eq('Project')
    end

    it 'should not assign bogus attributes' do
      task = TaskwarriorNagger::Task.new({:bogus => 'Testing'})
      task.respond_to?(:bogus).should be_false
    end
  end

  describe '#save!' do
    it 'should save the task' do
      task = TaskwarriorNagger::Task.new
      command = TaskwarriorNagger::Command.new(:add)
      command.should_receive(:run).once
      TaskwarriorNagger::Command.should_receive(:new).once.with(:add, nil, task.to_hash).and_return(command)
      task.save!
    end
  end

  describe '#complete!' do
    it 'should complete the task' do
      task = TaskwarriorNagger::Task.new({:uuid => 15})
      command = TaskwarriorNagger::Command.new(:complete)
      command.should_receive(:run).once
      TaskwarriorNagger::Command.should_receive(:new).once.with(:complete, 15).and_return(command)
      task.complete!
    end
  end

  describe '#delete!' do
    it 'should delete the task' do
      task = TaskwarriorNagger::Task.new({:uuid => 15})
      command = TaskwarriorNagger::Command.new(:delete)
      command.should_receive(:run).once
      TaskwarriorNagger::Command.should_receive(:new).once.with(:delete, 15).and_return(command)
      task.delete!
    end
  end

  describe '.query' do
    before do
      @command = TaskwarriorNagger::Command.new(:query)
      TaskwarriorNagger::Command.should_receive(:new).with(:query, nil).and_return(@command)
    end

    it 'should create and run a new Command object' do
      @command.should_receive(:run).and_return('{}')
      TaskwarriorNagger::Task.query
    end
  end

  describe '.count' do
    it 'just count the results of a query' do
      TaskwarriorNagger::Task.should_receive(:query).once.and_return(['hello'])
      TaskwarriorNagger::Task.count.should eq(1)
    end
  end

  describe '#tags=' do
    it 'should convert a string to an array when initializing' do
      task = TaskwarriorNagger::Task.new(:tags => 'hi, twice')
      task.tags.should eq(['hi', 'twice'])
    end

    it 'should convert a string to an array when setting explicitly' do
      task = TaskwarriorNagger::Task.new
      task.tags = 'hello, twice,thrice'
      task.tags.should eq(['hello', 'twice', 'thrice'])
    end

    it 'should break on any combination of spaces and commas' do
      try = ['hi twice and again', 'hi,twice,and,again', 'hi twice,and again', 'hi,  twice and  ,   again']

      try.each do |tags|
        task = TaskwarriorNagger::Task.new(:tags => tags)
        task.tags.should eq(['hi', 'twice', 'and', 'again'])
      end
    end

    it 'should support most characters' do
      task = TaskwarriorNagger::Task.new(:tags => '@hi, -twice, !again, ~when')
      task.tags.should eq(['@hi', '-twice', '!again', '~when'])
    end

    it 'should properly set tags for removal' do
      task = TaskwarriorNagger::Task.new({:tags => ['hello', 'goodbye']})
      TaskwarriorNagger::Task.should_receive(:find_by_uuid).and_return([task])
      task2 = TaskwarriorNagger::Task.new
      task2.uuid = 15
      task2.tags = ['goodbye']
      task2.tags.should eq(['goodbye'])
      task2.remove_tags.should eq(['hello'])
    end
  end

  describe '#to_hash' do
    before do
      @task = TaskwarriorNagger::Task.new(:description => 'Testing', :due => '12/2/12', :tags => 'hello, twice')
    end

    it 'should return a hash' do
      @task.to_hash.should be_a(Hash)
    end

    it 'should have keys for each of the object\'s instance variables' do
      @task.to_hash.should eq({:description => 'Testing', :due => '12/2/12', :tags => ['hello', 'twice'], :annotations => []})
    end
  end

  describe '.method_missing' do
    it 'should call the query method for find_by queries' do
      TaskwarriorNagger::Task.should_receive(:query).with('status' => 'pending')
      TaskwarriorNagger::Task.find_by_status(:pending)
    end

    it 'should call pass other methods to super if not find_by_*' do
      TaskwarriorNagger::Task.should_not_receive(:query)
      Object.should_receive(:method_missing).with(:do_a_thing, anything)
      TaskwarriorNagger::Task.do_a_thing(:pending)
    end

    it 'should make the class respond to find_by queries' do
      TaskwarriorNagger::Task.should respond_to(:find_by_test)
    end

    it 'should not add support for obviously bogus methods' do
      TaskwarriorNagger::Task.should_not respond_to(:wefiohhohiihihih)
    end
  end
end
