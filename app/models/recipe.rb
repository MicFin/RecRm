class Recipe < ActiveRecord::Base
  attr_accessor :ingredient_list
  attr_accessor :ingredient_count
  attr_accessor :step_list
  attr_accessor :health_groups
  attr_accessor :courses

  # exporting to excel
  # acts_as_xlsx :columns => [:id, :created_at, :name, :description, :serving_size, :prep_time, :cook_time, :difficulty, :'ingredients.size']

  # for roles
  resourcify

  has_many :ingredients_recipes
  has_many :ingredients, through: :ingredients_recipes
  has_many :recipe_steps
  has_and_belongs_to_many :characteristics, :uniq => true
  has_and_belongs_to_many :patient_groups, :uniq => true
  belongs_to :dietitian
  validates :name, :presence => {:message => 'cannot be blank, Recipe not saved'}
  # paperclip loaded image
  #   has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  # do_not_validate_attachment_file_type :avatar
  # validate :has_mandatory_characteristics
  # removed until can utlilize AJAX to render nested forms for recipe form or to submit for ingredients_recipes forms
  # accepts_nested_attributes_for :ingredients_recipes
  # quality reviews polymoprhic
  has_many :quality_reviews, as: :quality_reviewable
  has_many :marketing_items, as: :marketing_itemable
  has_many :review_conflicts, through: :quality_reviews

  def number_of_reviewers_hash
    reviewers_hash = {}
    total_count = 0
    unique_array = []
    unique_count = 0
    if self.quality_reviews != []
      self.quality_reviews.each do |quality_review|
        total_count += 1
        if unique_array.exclude? quality_review.dietitian_id
          unique_count += 1
          unique_array << quality_review.dietitian_id
        end
        if quality_review.review_conflicts != []
          quality_review.review_conflicts.each do |review_conflict|
            total_count += 1
            if unique_array.exclude? quality_review.dietitian_id
              unique_count += 1
              unique_array << quality_review.dietitian_id
            end
          end
        end
      end
    end
    reviewers_hash = {:total=>total_count, :unique=> unique_count}
    return reviewers_hash
  end

  def ingredient_with_full_name(full_name)
    self.ingredients_recipes.each do |ingredient|
      if ingredient.full_name == full_name
        return ingredient
      end
    end
    return false
  end

  def review_tier
    quality_reviews = self.quality_reviews
    if quality_reviews.count > 0
      if (quality_reviews.order("created_at").last.passed != true)
        review_tier = 1
      else
        review_tier = 2
      end
    else
      review_tier = 1
    end
    return review_tier
  end

  # recipe counts byt health group
  def self.data_by_health_group
    data_by_health_group_hash = {}
    PatientGroup.all.each do |health_group|
      data_by_health_group_hash[health_group.name] = {}
      health_group_recipes = Recipe.includes(:patient_groups).where('patient_groups.name = ?', health_group.name).references(:patient_group)
      data_by_health_group_hash[health_group.name]["Total"] = health_group_recipes.count
      data_by_health_group_hash[health_group.name]["Breakfast"] = health_group_recipes.includes(:characteristics).where('characteristics.name = ?', 'Breakfast').references(:characteristic).count
      data_by_health_group_hash[health_group.name]["Lunch"] = health_group_recipes.includes(:characteristics).where('characteristics.name = ?', 'Lunch').references(:characteristic).count
      data_by_health_group_hash[health_group.name]["Dinner"] = health_group_recipes.includes(:characteristics).where('characteristics.name = ?', 'Dinner').references(:characteristic).count
      data_by_health_group_hash[health_group.name]["Snack"] = health_group_recipes.includes(:characteristics).where('characteristics.name = ?', 'Snack').references(:characteristic).count
      data_by_health_group_hash[health_group.name]["Dessert"] = health_group_recipes.includes(:characteristics).where('characteristics.name = ?', 'Dessert').references(:characteristic).count
    end
    return data_by_health_group_hash
  end

  def self.data_by_total
    today = Date.today
    beginning_of_week = today.at_beginning_of_week(:thursday)
    data_by_total_hash = {}
    all_time_array = Recipe.all
    data_by_total_hash["total_all_time"] = all_time_array.count
    data_by_total_hash["made_for_all_time"] = 0
    all_time_array.each do |recipe|
      data_by_total_hash["made_for_all_time"] += recipe.patient_groups.count
    end
    this_weeks_array = Recipe.where(:created_at => beginning_of_week.beginning_of_day..today.end_of_day)
    data_by_total_hash["total_this_week"] = this_weeks_array.count
    data_by_total_hash["made_for_this_week"] = 0
    this_weeks_array.each do |recipe|
      data_by_total_hash["made_for_this_week"] += recipe.patient_groups.count
    end
    last_weeks_array = Recipe.where(:created_at => 1.week.ago.beginning_of_week.beginning_of_day..1.week.ago.end_of_week.end_of_day)
    data_by_total_hash["total_last_week"] = last_weeks_array.count
    data_by_total_hash["made_for_last_week"] = 0
    last_weeks_array.each do |recipe|
      data_by_total_hash["made_for_last_week"] += recipe.patient_groups.count
    end
    total_2_weeks_ago_array = Recipe.where(:created_at => 2.week.ago.beginning_of_week.beginning_of_day..2.week.ago.end_of_week.end_of_day)
    data_by_total_hash["total_2_weeks_ago"] = total_2_weeks_ago_array.count
    data_by_total_hash["made_for_2_weeks_ago"] = 0
    total_2_weeks_ago_array.each do |recipe|
      data_by_total_hash["made_for_2_weeks_ago"] += recipe.patient_groups.count
    end
    total_3_weeks_ago_array = Recipe.where(:created_at => 3.week.ago.beginning_of_week.beginning_of_day..3.week.ago.end_of_week.end_of_day)
    data_by_total_hash["total_3_weeks_ago"] = total_3_weeks_ago_array.count
    data_by_total_hash["made_for_3_weeks_ago"] = 0
    total_3_weeks_ago_array.each do |recipe|
      data_by_total_hash["made_for_3_weeks_ago"] += recipe.patient_groups.count
    end
    total_4_weeks_ago_array = Recipe.where(:created_at => 4.week.ago.beginning_of_week.beginning_of_day..4.week.ago.end_of_week.end_of_day)
    data_by_total_hash["total_4_weeks_ago"] = total_4_weeks_ago_array.count
    data_by_total_hash["made_for_4_weeks_ago"] = 0
    total_4_weeks_ago_array.each do |recipe|
      data_by_total_hash["made_for_4_weeks_ago"] += recipe.patient_groups.count
    end
    return data_by_total_hash
  end

  def self.data_by_dietitian
    today = Date.today
    beginning_of_week = today.at_beginning_of_week(:thursday)
    data_by_dietitian_hash = {}
    Dietitian.all.each do|dietitian|
      data_by_dietitian_hash[dietitian.email] = {}
      all_time_array = dietitian.recipes
      data_by_dietitian_hash[dietitian.email]["total_all_time"] = all_time_array.count
      data_by_dietitian_hash[dietitian.email]["made_for_all_time"] = 0
      all_time_array.each do |recipe|
        data_by_dietitian_hash[dietitian.email]["made_for_all_time"] += recipe.patient_groups.count
      end
      this_weeks_array = dietitian.recipes.where(:created_at => beginning_of_week.beginning_of_day..today.end_of_day)
      data_by_dietitian_hash[dietitian.email]["total_this_week"] = this_weeks_array.count
      data_by_dietitian_hash[dietitian.email]["made_for_this_week"] = 0
      this_weeks_array.each do |recipe|
        data_by_dietitian_hash[dietitian.email]["made_for_this_week"] += recipe.patient_groups.count
      end
      last_weeks_array = dietitian.recipes.where(:created_at => 1.week.ago.beginning_of_week.beginning_of_day..1.week.ago.end_of_week.end_of_day)
      data_by_dietitian_hash[dietitian.email]["total_last_week"] = last_weeks_array.count
      data_by_dietitian_hash[dietitian.email]["made_for_last_week"] = 0
      last_weeks_array.each do |recipe|
        data_by_dietitian_hash[dietitian.email]["made_for_last_week"] += recipe.patient_groups.count
      end
      total_2_weeks_ago_array = dietitian.recipes.where(:created_at => 2.week.ago.beginning_of_week.beginning_of_day..2.week.ago.end_of_week.end_of_day)
      data_by_dietitian_hash[dietitian.email]["total_2_weeks_ago"] = total_2_weeks_ago_array.count
      data_by_dietitian_hash[dietitian.email]["made_for_2_weeks_ago"] = 0
      total_2_weeks_ago_array.each do |recipe|
        data_by_dietitian_hash[dietitian.email]["made_for_2_weeks_ago"] += recipe.patient_groups.count
      end
      total_3_weeks_ago_array = dietitian.recipes.where(:created_at => 3.week.ago.beginning_of_week.beginning_of_day..3.week.ago.end_of_week.end_of_day)
      data_by_dietitian_hash[dietitian.email]["total_3_weeks_ago"] = total_3_weeks_ago_array.count
      data_by_dietitian_hash[dietitian.email]["made_for_3_weeks_ago"] = 0
      total_3_weeks_ago_array.each do |recipe|
        data_by_dietitian_hash[dietitian.email]["made_for_3_weeks_ago"] += recipe.patient_groups.count
      end
      total_4_weeks_ago_array = dietitian.recipes.where(:created_at => 4.week.ago.beginning_of_week.beginning_of_day..4.week.ago.end_of_week.end_of_day)
      data_by_dietitian_hash[dietitian.email]["total_4_weeks_ago"] = total_4_weeks_ago_array.count
      data_by_dietitian_hash[dietitian.email]["made_for_4_weeks_ago"] = 0
      total_4_weeks_ago_array.each do |recipe|
        data_by_dietitian_hash[dietitian.email]["made_for_4_weeks_ago"] += recipe.patient_groups.count
      end
    end
    return data_by_dietitian_hash
  end

  def fetch_categories_array
    return self.characteristics.map(&:name).uniq
  end
  # returns recipe's health groups as an array of strings
  def fetch_health_groups_array
    return self.patient_groups.map(&:name).uniq
  end

  def fetch_ingredients_allergens_hash
    ingredients_allergens_hash = {}
    self.ingredients.each do |ingredient|
      ingredients_allergens_hash[ingredient] = []
      ingredient.allergens.each do |allergen|
        ingredients_allergens_hash[ingredient].push(allergen.name)
      end
    end
    return ingredients_allergens_hash
  end


  def recipe_ingredients_full_names
    full_names = []
    self.ordered_ingredients.each do |ingredient|
      full_names << ingredient.full_name
    end
    return full_names
  end

  def fetch_possible_review_conflicts(quality_review)
    possible_review_conflicts = {}
    review_items_array = []
    review_conflicts = quality_review.review_conflicts
    review_conflicts.each do |review_conflict|
      possible_review_conflicts[review_conflict.item] = review_conflict
      review_items_array << review_conflict.item
    end
    new_conflict = ReviewConflict.new
    if ((review_items_array.include? "recipe-name") == false)
      possible_review_conflicts["recipe-name"] = new_conflict
    end
    if ((review_items_array.include? "prep-time") == false)
      possible_review_conflicts["prep-time"] = new_conflict
    end
    if ((review_items_array.include? "cook-time") == false)
      possible_review_conflicts["cook-time"] = new_conflict
    end
    if ((review_items_array.include? "difficulty") == false)
      possible_review_conflicts["difficulty"] = new_conflict
    end
    if ((review_items_array.include? "serving-size") == false)
      possible_review_conflicts["serving-size"] = new_conflict
    end

    self.ordered_ingredients.each do |ingredient|
      if ((review_items_array.include? "ingredient-#{ingredient.id}") == false)
        possible_review_conflicts["ingredient-#{ingredient.id}"] = new_conflict
      end
    end
    self.steps.each do |step|
      if ((review_items_array.include? "step-#{step.id}") == false)
        possible_review_conflicts["step-#{step.id}"] = new_conflict
      end
    end
    self.ingredients.each do |ingredient|
      if ((review_items_array.include? "allergen-#{ingredient.id}") == false)
        possible_review_conflicts["allergen-#{ingredient.id}"] = new_conflict
      end
    end
    if ((review_items_array.include? "health-groups") == false)
      possible_review_conflicts["health-groups"] = new_conflict
    end
    if ((review_items_array.include? "recipe-categories") == false)
      possible_review_conflicts["recipe-categories"] = new_conflict
    end
    self.marketing_items.each do |marketing_item|
      if ((review_items_array.include? "marketing-item-#{marketing_item.id}") == false)
        possible_review_conflicts["marketing-item-#{marketing_item.id}"] = new_conflict
      end
    end
    return possible_review_conflicts
  end

  def self.all_live_recipes
    live_recipes = []
    self.where(completed: true).where(live_recipe: true).each do |recipe|
      live_recipes << recipe
    end
    return live_recipes
  end

  def self.all_need_original_review
    recipes_not_reviewed = []
    self.where(completed: true).where(live_recipe: false).each do |recipe|
      if recipe.quality_reviews.count < 1
        recipes_not_reviewed << recipe
      end
    end
    return recipes_not_reviewed
  end

  def self.all_in_first_tier_review
    recipes_in_review = []
    self.where(completed: true).where(live_recipe: false).each do|recipe|
      if recipe.quality_reviews.count >= 1
        last_review = recipe.quality_reviews.order("created_at").last
        if ( (last_review.tier == 1) && (last_review.completed == false) )
          recipes_in_review << recipe
        end
      end
    end
    return recipes_in_review
  end

  def self.first_tier_not_resolved
    recipes_in_review = []
    self.where(completed: true).where(live_recipe: false).each do|recipe|
      if recipe.quality_reviews.count >= 1
        last_review = recipe.quality_reviews.order("created_at").last
        if ( (last_review.tier == 1) && (last_review.completed == true) && (last_review.resolved == false ) )
          recipes_in_review << recipe
        end
      end
    end
    return recipes_in_review
  end

  def self.all_in_second_tier_review
    recipes_in_review = []
    self.where(completed: true).where(live_recipe: false).each do|recipe|
      if recipe.quality_reviews.count >= 1
        last_review = recipe.quality_reviews.order("created_at").last
        if ( (last_review.tier == 2) && (last_review.completed == false) )
          recipes_in_review << recipe
        end
      end
    end
    return recipes_in_review
  end

  def self.second_tier_not_resolved
    recipes_in_review = []
    self.where(completed: true).where(live_recipe: false).each do|recipe|
      if recipe.quality_reviews.count >= 1
        last_review = recipe.quality_reviews.order("created_at").last
        if ( (last_review.tier == 2) && (last_review.completed == true) && (last_review.resolved == false) )
          recipes_in_review << recipe
        end
      end
    end
    return recipes_in_review
  end



  def self.all_need_first_tier_review
    recipes_not_reviewed = []
    self.where(completed: true).where(live_recipe: false).each do|recipe|
      if recipe.quality_reviews.count >= 1
        last_review = recipe.quality_reviews.order("created_at").last
        if ( (last_review.resolved == true) && (last_review.passed != true) )
          recipes_not_reviewed << recipe
        end
      end
    end
    return recipes_not_reviewed
  end

  def self.all_need_second_tier_review
    recipes_not_reviewed = []
    self.where(completed: true).where(live_recipe: false).each do|recipe|
      if recipe.quality_reviews.count >= 1
        last_review = recipe.quality_reviews.order("created_at").last
        last_review_passed = last_review.passed
        if ((last_review_passed == true) && (last_review.resolved == true))
          recipes_not_reviewed << recipe
        end
      end
    end
    return recipes_not_reviewed
  end

  # returns recipe steps by group
  def steps_by_group
    steps_groups = []
    self.recipe_steps.map {|step| steps_groups << step.group_name}
    steps_groups = steps_groups.compact.reject(&:empty?).uniq
    steps_by_group = {}
    self.recipe_steps.each do |step|
      steps_groups.each do |group|
        steps_by_group[group] = steps_by_group[group] || []
        steps_by_group[group] << step if step.group_name == group
        steps_by_group[group] = steps_by_group[group].sort_by(&:position)
      end
      if ( (step.group_name == nil) || (step.group_name == "") )
        steps_by_group["Main"] = steps_by_group["Main"] || []
        steps_by_group["Main"] << step
        steps_by_group["Main"] = steps_by_group["Main"].sort_by(&:position)
      end
    end
    return steps_by_group
  end

  # returns recipe ingredients in order
  def ordered_ingredients
    self.ingredients_recipes.sort_by(&:position)
  end


  # returns recipe steps in order
  def steps
    self.recipe_steps.sort_by(&:position)
  end

  # return hash of recipe marketing items by patient group and by title ad description
  def marketing_items_by_group
    items_by_group = {}
    self.marketing_items.each do |marketing_item|
      if marketing_item.patient_group_id == nil
        group = "General"
        group_id = 0
      else
        group_id = marketing_item.patient_group_id
        group = PatientGroup.find(group_id).name
      end
      if (items_by_group.has_key?(group) == false)
        items_by_group[group] = {"group_id" => group_id}
        items_by_group[group]["items"] = {}
      end
      if marketing_item.category == "title"
        items_by_group[group]["items"]["title"] = marketing_item
      elsif marketing_item.category == "description"
        items_by_group[group]["items"]["description"] = marketing_item
      end
    end
    return items_by_group
  end
  # return an array of all unique recipe titles
  def self.all_recipe_names
    return self.all.map(&:name).uniq
  end
  # return a recipe's ingredients that have already been tagged with allergens
  def ingredients_tagged
    tagged_ingredients = []
    self.ingredients.each do |ingredient|
      if ingredient.need_allergens? == false
        tagged_ingredients << ingredient
      end
    end
    return tagged_ingredients
  end

  # return a recipe's ingredients that have not yet been tagged with allergens
  def ingredients_not_tagged
    not_tagged_ingredients = []
    self.ingredients.each do |ingredient|
      if ingredient.need_allergens? == true
        not_tagged_ingredients << ingredient
      end
    end
    return not_tagged_ingredients
  end

  # return a recipe's Patient Groups with the category intolerance
  def intolerances
    intolerances=[]
    self.patient_groups.each do |patient_group|
      if patient_group.category.downcase == "intolerance"
        intolerances << patient_group
      end
    end
    return intolerances
  end

  # return a recipe's PAtient Groups with the category allergy
  def allergies
    allergies=[]
    self.patient_groups.each do |patient_group|
      if patient_group.category.downcase == "allergy"
        allergies << patient_group
      end
    end
    return allergies
  end

  # return a recipe's Patient Groups with the category disease
  def diseases
    diseases=[]
    self.patient_groups.each do |patient_group|
      if patient_group.category.downcase == "disease"
        diseases << patient_group
      end
    end
    return diseases
  end

  # return a recipe's allergens, used in recipes controller edit_recipe_group method to only show patient groups that are safe based on ingredient list when selecting recipe's patient groups
  def allergens
    allergens=[]
    self.ingredients.each do |ingredient|
      ingredient.allergens.each do |allergen|
        allergens << allergen
      end
    end
    return allergens.uniq
  end

  # return recipes that are made for patient groups entered as an array of strings
  def self.made_for(*patient_groups)
    num_groups = patient_groups.count
    arrays = Array.new(num_groups) { [] }

    patient_groups.each_with_index do |patient_group, index|
      arrays[index] << Recipe.includes(:patient_groups).where('patient_groups.name = ?', patient_group).references(:patient_group)
    end
    made_for_array = []
    for i in 0...num_groups
      if made_for_array != []
        made_for_array.flatten!
        made_for_array = arrays[i].flatten & made_for_array
      else
        made_for_array = arrays[i].flatten
      end
    end
    return made_for_array
  end
  # def has_mandatory_characteristics
  # end

end
