class CreateUserFamilies < ActiveRecord::Migration
  def change
    create_table :user_families do |t|
      t.belongs_to :user, index: true
      t.belongs_to :family, index: true
    end
  end
end
