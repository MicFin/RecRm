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

  def client_referral_sent(client)

    if client.qol_referral == true
      client.confirmation_sent_at.in_time_zone("Eastern Time (US & Canada)").strftime("%B %d, %Y %I:%M %p") if client.confirmation_sent_at?
    elsif client.invited_by
      client.invitation_sent_at.in_time_zone("Eastern Time (US & Canada)").strftime("%B %d, %Y %I:%M %p") if client.invitation_sent_at?
    else
      "None"
    end
  end

  def client_referral_accepted(client)

    if client.qol_referral == true
      client.confirmed_at.in_time_zone("Eastern Time (US & Canada)").strftime("%B %d, %Y %I:%M %p") if client.confirmed_at?
    elsif client.invited_by
      client.invitation_accepted_at.in_time_zone("Eastern Time (US & Canada)").strftime("%B %d, %Y %I:%M %p") if client.invitation_accepted_at?
    else
      "None"
    end
  end

end
