class AddAssessmentColumnsToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :client_assessment_sent, :boolean
    add_column :appointments, :client_assessment_sent_at, :datetime
    add_column :appointments, :provider_assessment_sent, :boolean
    add_column :appointments, :provider_assessment_sent_at, :datetime
  end
end
