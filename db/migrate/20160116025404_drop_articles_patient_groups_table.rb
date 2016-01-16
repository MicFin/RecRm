class DropArticlesPatientGroupsTable < ActiveRecord::Migration
  def change
drop_table :articles_patient_groups do |t|
   t.integer :article_id,      null: false
    t.integer :patient_group_id, null: false
end
  end
end
