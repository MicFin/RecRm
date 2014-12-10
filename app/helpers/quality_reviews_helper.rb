module QualityReviewsHelper

  def get_incomplete_quality_reviews!
    reviews = current_dietitian.incomplete_quality_reviews
    @incomplete_quality_reviews = []
    reviews.each do |review|
      review.recipe_title = review.recipe_name
      review.number_of_ingredients = review.ingredient_count
      review.health_groups_names = review.health_group_array
      @incomplete_quality_reviews << review 
    end
  end

end
