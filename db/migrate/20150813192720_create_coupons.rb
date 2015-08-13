class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :code, :unique => true
      t.string :description
      t.datetime :valid_from
      t.datetime :valid_until
      t.integer :redemption_limit, default: 1
      t.integer :redemptions_count, default: 0
      t.integer :amount
      t.string :type
      t.string :status

      t.belongs_to :user
      t.belongs_to :appointment  

      t.timestamps
  
    end
      add_index :coupons, :user_id
      add_index :coupons, :appointment_id

  end
end
