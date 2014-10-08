class ReviewConflict < ActiveRecord::Base
  belongs_to :quality_review
  belongs_to :first_reviewer, :class_name => 'Dietitian', :foreign_key => 'first_reviewer_id'
  belongs_to :second_reviewer, :class_name => 'Dietitian', :foreign_key => 'second_reviewer_id'
  belongs_to :third_reviewer, :class_name => 'Dietitian', :foreign_key => 'third_reviewer_id'
  resourcify
  

  def allergens_changes_hash
    allergens_changes = {}
    allergens_changes_array = self.first_suggestion.split(" <3<* ")
    allergens_changes["ingredient"] = allergens_changes_array[0]
    allergens_changes["common"] = allergens_changes_array[1]
    allergens_changes_array = allergens_changes_array.drop(2)
    allergens_changes["allergens"] = []
    allergens_changes_array.each do |allergen|
      allergens_changes["allergens"] << allergen
    end
    return allergens_changes
  end
  def ingredient_changes_hash
    ingredient_changes_hash = {}
    suggestion_array = self.first_suggestion.split("'")
    ingredient_changes_hash[:amount] = suggestion_array[1]
    ingredient_changes_hash[:unit] = suggestion_array[3]
    ingredient_changes_hash[:display_name] = suggestion_array[5]
    ingredient_changes_hash[:shopping_list_item] = suggestion_array[7]
    ingredient_changes_hash[:options] = suggestion_array[9]
    return ingredient_changes_hash
  end

  def step_changes_hash
    step_changes_hash = {}
    suggestion_array = self.first_suggestion.split(" <3<* ")
    step_changes_hash[:step_group_name] = suggestion_array[0]
    step_changes_hash[:directions] = suggestion_array[1]
    step_changes_hash[:ingredients] = suggestion_array[2]
    return step_changes_hash
  end

end
