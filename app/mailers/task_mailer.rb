class TaskMailer < ApplicationMailer
    default from: 'notificacoes@todoapp.com'
  
    def overdue_task_email(task)
      @task = task
      mail(to: @task.user.email, subject: "🚨 Sua tarefa '#{@task.title}' está atrasada!")
    end
  end
  