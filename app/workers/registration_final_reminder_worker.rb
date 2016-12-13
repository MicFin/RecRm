class RegistrationFinalReminderWorker
  include Sidekiq::Worker

  def perform(user_id)

    UserMailer.registration_final_reminder(user_id).deliver

  end

end