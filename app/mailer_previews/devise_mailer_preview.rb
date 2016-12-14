class DeviseMailerPreview

  def invitation_from_provider
    # devise_mail(record, :invitation_instructions, opts)
    mock_user = mock_user("Alice")
    Devise::Mailer.invitation_instructions(mock_user,"fdsafdsafsd")
  end

  def invitation_from_qol
    # devise_mail(record, :invitation_instructions, opts)
    mock_user = mock_user("Alice", true)
    Devise::Mailer.confirmation_instructions(mock_user,"fdsafdsafsd")
  end

  def reset_password
    mock_user = mock_user("Alice")
    Devise::Mailer.reset_password_instructions(mock_user,"fdsafdsafsd")
  end
  # def confirmation_instructions

  #   # devise_mail(record, :confirmation_instructions, opts)
  #   mock_user = mock_user("Alice")
  #   Devise::Mailer.confirmation_instructions(mock_user,"fdsafdsafsd")

  #     # you can provide values to be interpolated with %{}, e.g. "Hello %{user}"

  # end

  # # Not using unlock
  # def unlock_instructions
  #   mock_user = mock_user("Alice")
  #   Devise::Mailer.unlock_instructions(mock_user,"fdsafdsafsd")
  # end

  # def invitation_from_krdn
  #   # devise_mail(record, :invitation_instructions, opts)
  #   mock_user = mock_user("Alice")
  #   Devise::Mailer.invitation_instructions(mock_user,"fdsafdsafsd")
  # end

  # def invitation_from_client
  #   # devise_mail(record, :invitation_instructions, opts)
  #   mock_user = mock_user("Alice")
  #   Devise::Mailer.invitation_instructions(mock_user,"fdsafdsafsd")
  # end
  
  private
  # You can put all your mock helpers in a module
  # or you can use your factories / fabricators, just make sure you are not creating anything
  def mock_user(name = 'Bill Gates', qol_referral = false)
    fake_id User.new(first_name: name, email: "user#{rand 100}@test.com", qol_referral: qol_referral)
  end

  def fake_id(obj)
    # overrides the method on just this object
    obj.define_singleton_method(:id) { 123 + rand(100) }
    obj
  end
end