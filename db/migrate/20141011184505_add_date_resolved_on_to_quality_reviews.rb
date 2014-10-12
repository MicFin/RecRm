class AddDateResolvedOnToQualityReviews < ActiveRecord::Migration
  def change
    add_column :quality_reviews, :date_resolved_on, :datetime
  end
end
