class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone_number, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :sex, :string
    add_column :users, :height_inches, :integer
    add_column :users, :weight_ounces, :integer
    add_index(:users, :last_name)
    add_index(:users, :date_of_birth)
  end
end
