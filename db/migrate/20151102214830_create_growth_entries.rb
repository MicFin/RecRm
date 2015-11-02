class CreateGrowthEntries < ActiveRecord::Migration
  def change
    create_table :growth_entries do |t|
      t.references :growth_chart, index: true
      t.date :measured_at
      t.integer :height_in_inches
      t.integer :weight_in_ounces
      t.string :age

      t.timestamps
    end
  end
end
