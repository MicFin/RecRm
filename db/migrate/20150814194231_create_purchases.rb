class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.belongs_to :user, index: true
      t.integer :purchasable_id
      t.string :purchasable_type

      t.timestamps
    end
  end
end
