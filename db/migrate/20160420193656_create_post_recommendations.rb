class CreatePostRecommendations < ActiveRecord::Migration
  def change
    create_table :post_recommendations do |t|
      t.belongs_to :dietitian, index: true
      t.belongs_to :user, index: true
      t.text :message
      t.belongs_to :monologue_post, index: true
      t.belongs_to :appointment, index: true

      t.timestamps
    end
  end
end
