class AddPolymorphicToQualityReview < ActiveRecord::Migration
  def change
    add_column :quality_reviews, :quality_reviewable_id, :integer
    add_column :quality_reviews, :quality_reviewable_type, :string
    add_index :quality_reviews, [:quality_reviewable_id, :quality_reviewable_type], name: "quality_reviewable_id_index"
  end
end
