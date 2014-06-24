class CreateJoinTablePatientGroupsUsers < ActiveRecord::Migration
  def change
    create_join_table :patient_groups, :users do |t|
      # t.index [:patient_group_id, :user_id]
      # t.index [:user_id, :patient_group_id]
    end
  end
end
