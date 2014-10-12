class AddResolvedToQualityReviews < ActiveRecord::Migration
  def change
    add_column :quality_reviews, :resolved, :boolean, :default => false
  end
end
