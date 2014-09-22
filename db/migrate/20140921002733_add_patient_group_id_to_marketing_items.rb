class AddPatientGroupIdToMarketingItems < ActiveRecord::Migration
  def change
    add_reference :marketing_items, :patient_group, index: true
  end
end
