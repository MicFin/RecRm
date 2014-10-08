class AddDateStartedToQualityReviews < ActiveRecord::Migration
  def change
    add_column :quality_reviews, :date_started, :datetime
  end
end
