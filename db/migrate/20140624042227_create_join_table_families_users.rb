class CreateJoinTableFamiliesUsers < ActiveRecord::Migration
  def change
 	create_table :families_users, id: false do |t|
		t.integer :user_id
		t.integer :family_id
	end
  end
end
