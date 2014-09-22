class ReviewConflict < ActiveRecord::Base
  belongs_to :quality_review
  belongs_to :first_reviewer, :class_name => 'Dietitian', :foreign_key => 'first_reviewer_id'
  belongs_to :second_reviewer, :class_name => 'Dietitian', :foreign_key => 'second_reviewer_id'
  belongs_to :third_reviewer, :class_name => 'Dietitian', :foreign_key => 'third_reviewer_id'
end
