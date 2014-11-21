class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.belongs_to :member_plan, index: true
      t.belongs_to :user, index: true
      t.datetime :start_date
      t.datetime :end_date
      t.string :type

      t.timestamps
    end
  end
end
