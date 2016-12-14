class UserMailerPreview

  def registration_confirmation
    # devise_mail(record, :invitation_instructions, opts)
    mock_user = mock_user("Alice")
    UserMailer.registration_confirmation(mock_user)
  end

  def registration_reminder_1_day
    # devise_mail(record, :invitation_instructions, opts)
    mock_user = mock_user("Alice")
    UserMailer.registration_reminder_1_day(mock_user)
  end

  def registration_reminder_1_week
    mock_user = mock_user("Alice")
    UserMailer.registration_reminder_1_week(mock_user)
  end

  def appointment_confirmation
    mock_user = mock_user("Alice")
    UserMailer.appointment_confirmation(mock_user)
  end

  def appointment_reminder_3_day
    mock_user = mock_user("Alice")
    UserMailer.appointment_reminder_3_day(mock_user)
  end

  def appointment_reminder_1_day
    mock_user = mock_user("Alice")
    UserMailer.appointment_reminder_1_day(mock_user)
  end

  def appointment_reminder_1_hour
    mock_user = mock_user("Alice")
    UserMailer.appointment_reminder_1_hour(mock_user)
  end

  def appointment_late_5_minutes
    mock_user = mock_user("Alice")
    UserMailer.appointment_late_5_minutes(mock_user)
  end

  def appointment_missed
    mock_user = mock_user("Alice")
    UserMailer.appointment_missed(mock_user)
  end

  def appointment_assessment_ready
    mock_user = mock_user("Alice")
    UserMailer.appointment_assessment_ready(mock_user)
  end

  private
  # You can put all your mock helpers in a module
  # or you can use your factories / fabricators, just make sure you are not creating anything
  def mock_user(name = 'Bill Gates')
    fake_id User.new(first_name: name, email: "user#{rand 100}@test.com")
  end

  def fake_id(obj)
    # overrides the method on just this object
    obj.define_singleton_method(:id) { 123 + rand(100) }
    obj
  end
end