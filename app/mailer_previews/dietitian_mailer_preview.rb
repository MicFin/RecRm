class DietitianMailerPreview

  def appointment_confirmation
    # devise_mail(record, :invitation_instructions, opts)
    mock_dietitian = mock_dietitian("Alice")
    DietitianMailer.appointment_confirmation(mock_dietitian)
  end

  private
  # You can put all your mock helpers in a module
  # or you can use your factories / fabricators, just make sure you are not creating anything
  def mock_dietitian(name = 'Bill Gates')
    fake_id Dietitian.new(first_name: name, email: "user#{rand 100}@test.com")
  end

  def fake_id(obj)
    # overrides the method on just this object
    obj.define_singleton_method(:id) { 123 + rand(100) }
    obj
  end
end
