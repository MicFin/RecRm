class CreateUserPackages < ActiveRecord::Migration
  def change
    create_table :user_packages do |t|
      t.references :user, index: true
      t.references :package, index: true
      t.date :purchase_date
      t.date :expiration_date
    end
  end
end
