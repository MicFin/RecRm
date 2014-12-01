class AddFamilyRoleToUser < ActiveRecord::Migration
  def change
      add_column :users, :family_role, :string
  end
end
