class AddDetailsToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :last_updated_at, :datetime
    add_column :surveys, :completed_at, :datetime
  end
end
