# Preview all emails at http://localhost:3000/rails/mailers/task_mailer
class TaskMailerPreview < ActionMailer::Preview
    <p>Olá <%= @task.user.name || @task.user.email %>,</p>

    <p>A tarefa <strong><%= @task.title %></strong> venceu em <%= @task.due_date.strftime('%d/%m/%Y') %> e ainda não foi concluída.</p>

    <p>Não se esqueça de finalizá-la o quanto antes! 🚀</p>

    <p>Atenciosamente,</p>
    <p><strong>Equipe TodoApp</strong></p>

end
