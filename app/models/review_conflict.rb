class ReviewConflict < ActiveRecord::Base
  belongs_to :quality_review
  belongs_to :first_reviewer, :class_name => 'Dietitian', :foreign_key => 'first_reviewer_id'
  belongs_to :second_reviewer, :class_name => 'Dietitian', :foreign_key => 'second_reviewer_id'
  belongs_to :third_reviewer, :class_name => 'Dietitian', :foreign_key => 'third_reviewer_id'
  resourcify
  
  def self.assigned_to_dietitian(dietitian_id)
    assigned = []
    assigned += ReviewConflict.where(second_reviewer_id: dietitian_id).where(resolved: false).where(review_stage: 1)
    assigned += ReviewConflict.where(third_reviewer_id: dietitian_id).where(resolved: false)
    return assigned
  end

  def needs_to_be_assigned?
    if self.review_stage  == 3
        return false
    elsif self.review_stage  == 2
      if self.third_reviewer_id == nil
        return true
      else
        return false
      end
    else
      if self.second_reviewer_id == nil
        return true
      else
        return false
      end
    end
  end

  def self.assign_by_risk_level
    conflicts_by_risk_level = {}
    conflicts_by_risk_level[1] = []
    conflicts_by_risk_level[2] = []
    conflicts_by_risk_level[3] = []
    conflicts_by_risk_level[4] = []
    
    self.where(resolved: false).each do |review_conflict|
          
      if review_conflict.needs_to_be_assigned?
        
        conflicts_by_risk_level[review_conflict.risk_level] << review_conflict
      end
    end

    return conflicts_by_risk_level
  end

  def self.in_review_by_risk_level
    conflicts_by_risk_level = {}
    conflicts_by_risk_level[1] = []
    conflicts_by_risk_level[2] = []
    conflicts_by_risk_level[3] = []
    conflicts_by_risk_level[4] = []
    self.where(resolved: false).each do |review_conflict|
      
      if (review_conflict.needs_to_be_assigned? == false)

        conflicts_by_risk_level[review_conflict.risk_level] << review_conflict
      end
    end

    return conflicts_by_risk_level
  end


  def recipe_categories_changes_array(*suggestion)
    recipes_categories_changes = []
    if suggestion.include? " <3<* "
      recipes_categories_changes = suggestion.split(" <3<* ")
    else
      recipes_categories_changes = self.first_suggestion.split(" <3<* ")
    end
    return recipes_categories_changes.uniq
  end  
  
  def health_groups_changes_array(*suggestion)
    health_groups_array = []
    if suggestion.include? " <3<* "
        health_groups_array = suggestion.split(" <3<* ")
    else
      health_groups_array = self.first_suggestion.split(" <3<* ")
    end
    return health_groups_array.uniq
  end  

  def allergens_changes_hash(*suggestion)
    allergens_changes = {}
    if suggestion.include? " <3<* "
      allergens_changes_array = suggestion.split(" <3<* ")
    else
      allergens_changes_array = self.first_suggestion.split(" <3<* ")
    end
    allergens_changes["ingredient"] = allergens_changes_array[0]
    allergens_changes["common"] = allergens_changes_array[1]
    allergens_changes_array = allergens_changes_array.drop(2)
    allergens_changes["allergens"] = []
    allergens_changes_array.each do |allergen|
      allergens_changes["allergens"] << allergen
    end
    return allergens_changes
  end

  def ingredient_changes_hash(*suggestion)
    ingredient_changes = {}
     if suggestion.include? "'"
        suggestion_array = suggestion.split("'")
    else
      suggestion_array = self.first_suggestion.split("'")
    end
    ingredient_changes[:amount] = suggestion_array[1]
    ingredient_changes[:unit] = suggestion_array[3]
    ingredient_changes[:display_name] = suggestion_array[5]
    ingredient_changes[:shopping_list_item] = suggestion_array[7]
    ingredient_changes[:options] = suggestion_array[9]
    return ingredient_changes
  end

  def step_changes_hash(*suggestion)
    step_changes_hash = {}
    if suggestion.include? " <3<* " 
        suggestion_array = suggestion.split(" <3<* ")
    else
      suggestion_array = self.first_suggestion.split(" <3<* ")
    end
    step_changes_hash[:step_group_name] = suggestion_array[0]
    step_changes_hash[:directions] = suggestion_array[1]
    step_changes_hash[:ingredients] = suggestion_array[2]
    return step_changes_hash
  end

end
