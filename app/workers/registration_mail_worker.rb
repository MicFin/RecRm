class RegistrationMailWorker
  include Sidekiq::Worker

  def perform(user_id, registration_mailer)
    user = User.find(user_id)
    # For confirmation
    if registration_mailer == "confirmation"
      # Send confirmation 
      UserMailer.registration_confirmation(user).deliver
      # Set 1 day reminder
      RegistrationMailWorker.perform_in(1.day, user_id, "reminder_1_day")

    # For 1 day reminder
    elsif registration_mailer == "reminder_1_day"
      # Send 1 day reminder 
      UserMailer.registration_reminder_1_day(user).deliver
      # Set 1 week reminder 
      RegistrationMailWorker.perform_in(7.day, user_id, "reminder_1_week")

    # For 1 week reminder
    elsif registration_mailer == "reminder_1_week"
      # Send 1 week reminder
      UserMailer.registration_reminder_1_day(user).deliver
    # For no registration mailer do nothing
    else
     false
    end
  end
end

# class HardWorker
#   include Sidekiq::Worker
#   def perform(name, count)
#     # do something
#   # attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
#   end
# end

# Create a job to be processed asynchronously:
# HardWorker.perform_async('bob', 5)
# Note that perform is an instance method, whereas perform_async is called on the class.

# You can also create a job to be processed in the future:
# HardWorker.perform_in(5.minutes, 'bob', 5)

# You can also create jobs by calling the delay method on a class method:
# User.delay.do_some_stuff(current_user.id, 20)

# There are two ways to create a job in your application code:
# MyWorker.perform_async(1, 2, 3)
# Sidekiq::Client.push('class' => MyWorker, 'args' => [1, 2, 3])  # Lower-level generic API

# Allows customization for this type of Worker.
#   :queue - use a named queue for this Worker, default 'default'
#   :retry - enable the RetryJobs middleware for this Worker, default *true*
#   :timeout - timeout the perform method after N seconds, default *nil*
#   :backtrace - whether to save any error backtrace in the retry payload to display in web UI,
#      can be true, false or an integer number of lines to save, default *false*