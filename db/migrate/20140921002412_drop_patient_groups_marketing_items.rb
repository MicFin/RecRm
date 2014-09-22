class DropPatientGroupsMarketingItems < ActiveRecord::Migration
  def up
    drop_table :patient_groups_marketing_items
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
