class CreateContentQuotas < ActiveRecord::Migration
  def change
    create_table :content_quotas do |t|
      t.integer :quality_reviews
      t.integer :review_conflicts
      t.integer :recipes
      t.belongs_to :dietitian, index: true

      t.timestamps
    end
  end
end
