class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :packages, :type, :category
    rename_column :coupons, :type, :amount_type
  end
end
