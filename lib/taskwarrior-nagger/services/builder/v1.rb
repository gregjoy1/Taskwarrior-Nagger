module TaskwarriorNagger::CommandBuilder::V1

  include TaskwarriorNagger::CommandBuilder::Base

  def build
    unless @command_string
      task_command
      substitute_parts if @command_string =~ /:id/
    end
    parse_params
    @built = "#{self.command_string}#{params}"
  end

  # Overridden from TaskwarriorNagger::CommandBuilder::Base
  #
  # Substitute the task's ID for its UUID.
  def substitute_parts
    if @id
      assign_id_from_uuid
      @command_string.gsub!(':id', @id.to_s)
      return self
    end
    raise TaskwarriorNagger::CommandBuilder::MissingTaskIDError
  end

  def assign_id_from_uuid
    @all_tasks ||= TaskwarriorNagger::Task.query('status.not' => [:deleted, :completed])
    @id = @all_tasks.index { |task| task.uuid == @id } + 1
  end
end
