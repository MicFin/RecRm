class Dietitian < ActiveRecord::Base
  rolify

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

  def incomplete_recipes
    incomplete_recipes = []
    self.recipes.each do |recipe|
      if recipe.completed == false
        incomplete_recipes << recipe
      end
    end
    return incomplete_recipes
  end

  def incomplete_quality_reviews
    incomplete_quality_reviews = []
    self.quality_reviews.each do |quality_review|
      if quality_review.completed == false 
        incomplete_quality_reviews << quality_review
      end
    end
  end

  def completed_quality_reviews
    complete_quality_reviews = []
    self.quality_reviews.each do |quality_review|
      if quality_review.completed == true 
        complete_quality_reviews << quality_review
      end
    end
  end
  
end
