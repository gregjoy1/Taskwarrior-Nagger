module TaskwarriorWeb
  module Nagger
    class Evening

      def initialize
        get_tasks
      end

      def should_run?
        (@uncompleted_tasks + @completed_tasks).any?
      end

      def get_message
        message = []

        if @completed_tasks.any?
          task_plural = "task#{@completed_tasks.count > 1 ? 's' : ''}"

          message.push("Nice one!")
          message.push("You completed #{@completed_tasks.count} #{task_plural} today!")
        end

        if @uncompleted_tasks.any?
          message.push("One the other hand, you didnt complete:")

          @uncompleted_tasks.first(4).each do |task|
            # With the query in get_tasks, we know any task not due today is overdue.
            due = (task.due.to_time.today? ? 'due today' :  'overdue')

            message.push("* #{task.description} (#{due})")
          end
        end

        message.push("What have you learnt today?")

        message.join("\n")
      end

      def get_tasks
        # leverage task warrior filter to find completed tasks today
        @completed_tasks = ::TaskwarriorWeb::Task.query('end.after:today-day completed')

        @uncompleted_tasks = ::TaskwarriorWeb::Task.query(status: 'pending').select do |task|
          next if task.due.nil?

          overdue = (task.due.to_time < 0.day.ago)
          due_today = (task.due.to_time.today?)

          overdue || due_today
        end
      end
    end
  end
end

