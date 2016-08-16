class DropActiveAdminCommentsTable < ActiveRecord::Migration
  def change
    drop_table :active_admin_comments do |t|
      t.string   :namespace
      t.text     :body
      t.string   :resource_id,   null: false
      t.string   :resource_type, null: false
      t.integer  :author_id
      t.string   :author_type
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
