class CreatePatientGroupsMarketingItems < ActiveRecord::Migration

  def self.up
    create_table :patient_groups_marketing_items, :id => false do |t|
        t.references :patient_group
        t.references :marketing_item
    end
    add_index :patient_groups_marketing_items, [:patient_group_id, :marketing_item_id], :name => "patient_marketing_index"
    add_index :patient_groups_marketing_items, :marketing_item_id
  end

  def self.down
    drop_table :patient_groups_marketing_items
  end
end
