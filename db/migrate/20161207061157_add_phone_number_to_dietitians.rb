class AddPhoneNumberToDietitians < ActiveRecord::Migration
  def change
    add_column :dietitians, :phone_number, :string
  end
end
