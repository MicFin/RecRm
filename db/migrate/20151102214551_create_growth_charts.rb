class CreateGrowthCharts < ActiveRecord::Migration
  def change
    create_table :growth_charts do |t|
      t.references :user, index: true

      t.timestamps
    end
  end
end
