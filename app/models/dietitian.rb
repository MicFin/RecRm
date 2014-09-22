class Dietitian < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :appointments
  has_many :marketing_items
  has_many :quality_reviews
  has_many :articles
  has_many :recipes
  has_many :review_conflicts
  has_many :first_reviewers, :class_name => "ReviewConflict", :foreign_key => "first_reviewer_id"
  has_many :second_reviewers, :class_name => "ReviewConflict", :foreign_key => "second_reviewer_id"
  has_many :third_reviewers, :class_name => "ReviewConflict", :foreign_key => "third_reviewer_id"
end
