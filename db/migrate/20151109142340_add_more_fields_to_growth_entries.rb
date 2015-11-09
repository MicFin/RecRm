class AddMoreFieldsToGrowthEntries < ActiveRecord::Migration
  def change
    add_column :growth_entries, :energy_requirement, :string
    add_column :growth_entries, :protein_requirement, :integer
    add_column :growth_entries, :fluids_requirement, :integer
  end
end
