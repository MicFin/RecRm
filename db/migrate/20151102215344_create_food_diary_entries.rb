class CreateFoodDiaryEntries < ActiveRecord::Migration
  def change
    create_table :food_diary_entries do |t|
      t.references :food_diary, index: true
      t.datetime :consumed_at
      t.string :food_item
      t.string :location
      t.text :note

      t.timestamps
    end
  end
end
