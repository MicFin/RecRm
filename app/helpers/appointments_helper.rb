# == Schema Information
#
# Table name: appointments
#
#  id                  :integer          not null, primary key
#  patient_focus_id    :integer
#  appointment_host_id :integer
#  dietitian_id        :integer
#  room_id             :integer
#  note                :text
#  client_note         :text
#  created_at          :datetime
#  updated_at          :datetime
#  start_time          :datetime
#  end_time            :datetime
#  stripe_card_token   :string(255)
#  regular_price       :integer
#  invoice_price       :integer
#  duration            :integer
#  other_note          :text
#  time_slot_id        :integer
#  status              :string(255)
#  registration_stage  :integer          default(0)
#  client_prepped      :boolean
#  dietitian_prepped   :boolean
#

module AppointmentsHelper


  # Get appointment family info
  def get_appointment_family_info!

    @family = @appointment.appointment_host.head_of_families.first
    if !@family.nil?
      @family.children = @family.users
      @family.family_members = []
      @family.family_members << @family.children << @appointment.appointment_host
      @family.family_members.flatten!
    end

  end

  def assign_appointments_prompt(appointments_no_dietitian)

    if appointments_no_dietitian.count > 0 
      render "appointments/index/appointments_no_dietitian_table", appointments_no_dietitian: appointments_no_dietitian
    else 
      render "appointments/index/appointments_no_dietitians_to_assign"  
    end   
  end

end
