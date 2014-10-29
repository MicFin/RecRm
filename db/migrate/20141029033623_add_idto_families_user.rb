class AddIdtoFamiliesUser < ActiveRecord::Migration
  def change
    add_column :families_users, :id, :primary_key
  end
end
