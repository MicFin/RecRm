class PostRecommendation < ActiveRecord::Base
  belongs_to :dietitian
  belongs_to :user
  belongs_to :monologue_post
  belongs_to :appointment
end
