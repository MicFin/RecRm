class AddRegistrationStageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :registration_stage, :integer, default: 0
  end
end
