class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :taste
      t.string :cook_time
      t.string :prep_time
      t.string :difficulty
      t.string :course
      t.string :age_group
      t.string :target_group
      t.integer :dietitian_id

      t.timestamps
    end
  end
end
