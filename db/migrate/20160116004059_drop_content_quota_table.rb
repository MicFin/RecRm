class DropContentQuotaTable < ActiveRecord::Migration
  def change
    drop_table :content_quotas do |t|
      t.integer  :quality_reviews
      t.integer  :review_conflicts
      t.integer  :recipes
      t.integer  :dietitian_id
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
