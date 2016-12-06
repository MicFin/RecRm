module GuestUsersHelper

  def client_referrer(client)

    if client.qol_referral == true
      "QOL"
    elsif client.invited_by
      "#{client.invited_by.first_name} #{client.invited_by.last_name}" 
    else
      "None"
    end
  end
end
