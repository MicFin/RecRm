class AddFieldsToGrowthEntries < ActiveRecord::Migration
  def change
    add_column :growth_entries, :height_percentile, :integer
    add_column :growth_entries, :height_z_score, :integer
    add_column :growth_entries, :weight_percentile, :integer
    add_column :growth_entries, :weight_z_score, :integer
    add_column :growth_entries, :bmi_percentile, :integer
    add_column :growth_entries, :bmi_z_score, :integer
    add_column :growth_entries, :dietitian_note, :text
    add_column :growth_entries, :client_note, :text
  end
end
