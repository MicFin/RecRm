class CreateMemberPlans < ActiveRecord::Migration
  def change
    create_table :member_plans do |t|
      t.string :name

      t.timestamps
    end
  end
end
