class RegistrationConfirmationWorker
  include Sidekiq::Worker

  def perform(user_id)

    UserMailer.new_appointment(user_id).deliver
    
  end

end
