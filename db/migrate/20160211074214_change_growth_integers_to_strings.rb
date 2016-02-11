class ChangeGrowthIntegersToStrings < ActiveRecord::Migration

  def self.up
    change_column :growth_entries, :height_percentile, :string
    change_column :growth_entries, :height_z_score, :string
    change_column :growth_entries, :weight_percentile, :string
    change_column :growth_entries, :weight_z_score, :string
    change_column :growth_entries, :bmi_percentile, :string
    change_column :growth_entries, :bmi_z_score, :string
    change_column :growth_entries, :protein_requirement, :string
    change_column :growth_entries, :fluids_requirement, :string
  end

  def self.down
    change_column :growth_entries, :height_percentile, :integer
    change_column :growth_entries, :height_z_score, :integer
    change_column :growth_entries, :weight_percentile, :integer
    change_column :growth_entries, :weight_z_score, :integer
    change_column :growth_entries, :bmi_percentile, :integer
    change_column :growth_entries, :bmi_z_score, :integer
    change_column :growth_entries, :protein_requirement, :integer
    change_column :growth_entries, :fluids_requirement, :integer
  end

end
