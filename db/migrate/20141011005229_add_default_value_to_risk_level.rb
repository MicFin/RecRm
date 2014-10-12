class AddDefaultValueToRiskLevel < ActiveRecord::Migration
  def up
    change_column :review_conflicts, :resolved, :boolean, :default => false
  end

  def down
    change_column :review_conflicts, :resolved, :boolean, :default => nil
  end
end
