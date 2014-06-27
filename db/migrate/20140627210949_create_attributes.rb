class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.string :category
      t.string :name

      t.timestamps
    end
  end
end
