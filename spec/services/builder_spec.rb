require File.dirname(__FILE__) + '/../spec_helper'
require 'taskwarrior-nagger/services/builder'

RSpec::Mocks::setup(TaskwarriorNagger::Config)

describe TaskwarriorNagger::CommandBuilder do
  describe '.included' do
    context 'when v2 is reported' do
      it 'should include CommandBuilder V2 module' do
        TaskwarriorNagger::Config.should_receive(:version).and_return(Versionomy.parse('2.0.0'))
        TestCommandClass.class_eval { include TaskwarriorNagger::CommandBuilder }
        TestCommandClass.should include(TaskwarriorNagger::CommandBuilder::V2)
      end
    end

    context 'when v1 is reported' do
      it 'should include CommandBuilder V1 module' do
        TaskwarriorNagger::Config.should_receive(:version).and_return(Versionomy.parse('1.0.0'))
        TestCommandClass.class_eval { include TaskwarriorNagger::CommandBuilder }
        TestCommandClass.should include(TaskwarriorNagger::CommandBuilder::V1)
      end
    end

    context 'when an invalid version number is reported' do
      it 'should throw an UnrecognizedTaskVersion exception' do
        TaskwarriorNagger::Config.should_receive(:version).and_return(Versionomy.parse('9.0.0'))
        expect { 
          TestCommandClass.class_eval { include TaskwarriorNagger::CommandBuilder }
        }.to raise_exception(TaskwarriorNagger::UnrecognizedTaskVersion)
      end
    end
  end
end

class TestCommandClass; end
