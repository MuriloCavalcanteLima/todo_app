every 1.day, at: '10:00 am' do
    runner "TaskDueDateNotifierJob.perform_later"
end

# whenever --update-crontab <- activate cron, but first, configure the email on config/environments/development.rb