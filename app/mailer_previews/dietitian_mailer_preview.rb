class DietitianMailerPreview

  def appointment_confirmation
    # devise_mail(record, :invitation_instructions, opts)
    mock_user = mock_user("Alice")
    DietitianMailer.appointment_confirmation(mock_user)
  end
end
