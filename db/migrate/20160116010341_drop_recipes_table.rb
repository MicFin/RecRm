class DropRecipesTable < ActiveRecord::Migration
  def change
    drop_table :recipes do |t|
      t.string   :name
      t.integer  :dietitian_id
      t.datetime :created_at
      t.datetime :updated_at
      t.text     :description
      t.text     :inspiration
      t.string   :avatar_file_name
      t.string   :avatar_content_type
      t.integer  :avatar_file_size
      t.datetime :avatar_updated_at
      t.text     :image_url
      t.integer  :serving_size
      t.string   :prep_time
      t.string   :cook_time
      t.string   :difficulty
      t.integer  :creation_stage
      t.boolean  :completed,           default: false
      t.boolean  :live_recipe,         default: false, null: false
    end
  end
end
