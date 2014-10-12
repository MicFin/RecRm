class AddTierToQualityReview < ActiveRecord::Migration
  def change
    add_column :quality_reviews, :tier, :integer, :default => 1
  end
end
