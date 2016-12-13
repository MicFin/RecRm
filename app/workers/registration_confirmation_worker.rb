class RegistrationConfirmationWorker
  include Sidekiq::Worker

  def perform(user_id)

    UserMailer.registration_confirmation(user_id).deliver
    
  end

end
