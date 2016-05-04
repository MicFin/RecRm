class PostRecommendation < ActiveRecord::Base
  belongs_to :dietitian
  belongs_to :user
  belongs_to :monologue_post, class_name: 'Monologue::Post'
  belongs_to :appointment
  default_scope{includes(:monologue_post)}
end
