class TaskDueDateNotifier
    def self.call
      overdue_tasks = Task.where("due_date < ? AND completed = ?", Date.today, false)
      
      overdue_tasks.each do |task|
        TaskMailer.overdue_task_email(task).deliver_later
      end
    end
  end
  