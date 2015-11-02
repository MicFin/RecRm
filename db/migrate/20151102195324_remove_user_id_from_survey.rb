class RemoveUserIdFromSurvey < ActiveRecord::Migration
  def change
    remove_column :surveys, :user_id, :integer
  end
end
