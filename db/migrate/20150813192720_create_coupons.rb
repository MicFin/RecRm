class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :code
      t.string :description
      t.date_time :valid_from
      t.date_time :valid_until
      t.integer :redemption_limit
      t.integer :redemptions_count
      t.integer :amount
      t.string :type
      t.string :status

      t.timestamps
    end
  end
end
