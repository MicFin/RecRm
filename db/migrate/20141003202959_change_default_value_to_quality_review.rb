class ChangeDefaultValueToQualityReview < ActiveRecord::Migration
  def change
    change_column :quality_reviews, :completed, :boolean, :null => false, :default=> false
  end
end
