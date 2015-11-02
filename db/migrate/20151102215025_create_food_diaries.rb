class CreateFoodDiaries < ActiveRecord::Migration
  def change
    create_table :food_diaries do |t|
      t.references :user, index: true

      t.timestamps
    end
  end
end
