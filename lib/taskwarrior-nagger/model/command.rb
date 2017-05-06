class TaskwarriorNagger::Command
  include TaskwarriorNagger::CommandBuilder
  include TaskwarriorNagger::Runner

  attr_accessor :command, :id, :params, :built, :command_string

  def initialize(command, id = nil, *args)
    @command = command if command
    @id = id if id
    @params = args.last.is_a?(::Hash) ? args.pop : {}
  end
end
