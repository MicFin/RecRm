class DropArticlesAgainTable < ActiveRecord::Migration
  def change
  drop_table :articles do |t|
    t.text     :content
    t.integer  :dietitian_id
    t.string   :title
    t.datetime :created_at
    t.datetime :updated_at
  end
  end


end