class CreateGuestUsers < ActiveRecord::Migration
  def change
    create_table :guest_users do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email_address
      t.string :title
      t.string :company
      t.text :purpose
      t.text :help

      t.timestamps
    end
  end
end
