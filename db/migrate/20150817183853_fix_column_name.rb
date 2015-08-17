class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :packages, :type, :category
  end
end
