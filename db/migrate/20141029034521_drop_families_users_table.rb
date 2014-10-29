class DropFamiliesUsersTable < ActiveRecord::Migration
    def up
      drop_table :families_users
    end

    def down
      create_table :families_users, id: false do |t|
        t.integer :user_id
        t.integer :family_id
      end
    end
end
