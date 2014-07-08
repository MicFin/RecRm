class CreateJoinTableArticlesPatientGroups < ActiveRecord::Migration
  def change
    create_table :articles_patient_groups, id: false do |t|
      t.integer :article_id
      t.integer :patient_group_id
    end

    add_index :articles_patient_groups, :article_id
    add_index :articles_patient_groups, :patient_group_id

  end
end
