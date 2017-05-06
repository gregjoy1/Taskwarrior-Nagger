module TaskwarriorNagger
  module Nagger
    class Morning

      def initialize
        get_tasks
        sort_tasks
      end

      def should_run?
        @tasks.any?
      end

      def get_message
        message = []

        message.push("Today, you need to:")

        @tasks.first(4).each do |task|
          # With the query in get_tasks, we know any task not due today is overdue.
          due = (task.due.to_time.today? ? 'due today' :  'overdue')

          message.push("* #{task.description} (#{due})")
        end

        message.push("Good luck!")

        message.join("\n")
      end

      def get_tasks
        @tasks = ::TaskwarriorNagger::Task.query(status: 'pending').select do |task|
          next if task.due.nil?

          overdue = (task.due.to_time < 0.day.ago)
          due_today = (task.due.to_time.today?)

          overdue || due_today
        end
      end

      def sort_tasks
        @tasks = @tasks.sort_by { |task| task.urgency }.reverse!
      end
    end
  end
end

