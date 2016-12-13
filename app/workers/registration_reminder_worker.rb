class RegistrationReminderWorker
  include Sidekiq::Worker

  def perform(user_id)

    UserMailer.registration_reminder(user_id).deliver

  end

end