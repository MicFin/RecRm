class RolifyCreateUserRoles < ActiveRecord::Migration
  def change
    create_table(:user_roles) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:users_user_roles, :id => false) do |t|
      t.references :user
      t.references :user_role
    end

    add_index(:user_roles, :name)
    add_index(:user_roles, [ :name, :resource_type, :resource_id ])
    add_index(:users_user_roles, [ :user_id, :user_role_id ])
  end
end
