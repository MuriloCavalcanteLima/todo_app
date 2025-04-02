class TaskDueDateNotifierJob < ApplicationJob
  queue_as :default

  def perform(*args)
    TaskDueDateNotifier.call
  end
end
