class Recipe < ActiveRecord::Base
  attr_accessor :ingredient_list
  attr_accessor :step_list
  attr_accessor :characteristic_list
  attr_accessor :courses
  attr_accessor :age_groups
  attr_accessor :scenarios
  attr_accessor :holidays
  attr_accessor :cultures

  resourcify

	has_many :ingredients_recipes
	has_many :ingredients, through: :ingredients_recipes
	has_many :recipe_steps
  has_and_belongs_to_many :characteristics, :uniq => true
  has_and_belongs_to_many :patient_groups, :uniq => true
  belongs_to :dietitian
  validates :name, :presence => {:message => 'cannot be blank, Recipe not saved'}
  # paperclip loaded image 
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  do_not_validate_attachment_file_type :avatar
  # validate :has_mandatory_characteristics
  # removed until can utlilize AJAX to render nested forms for recipe form or to submit for ingredients_recipes forms
  # accepts_nested_attributes_for :ingredients_recipes
  # quality reviews polymoprhic
  has_many :quality_reviews, as: :quality_reviewable 
  has_many :marketing_items, as: :marketing_itemable 
  has_many :review_conflicts, through: :quality_reviews
 
  def self.data_by_health_group
    data_by_health_group_hash = {}
    # PatientGroup.all.each do |health_group|
    #   data_by_health_group_hash[health_group.name] = {}
    #   health_group_recipes = Recipe.includes(:patient_groups).where('patient_groups.name = ?', health_group.name).references(:patient_group)
    #   data_by_health_group_hash[health_group.name]["Total"] = health_group_recipes.count
    #   data_by_health_group_hash[health_group.name]["Breakfast"] = health_group_recipes.includes(:characteristics).where('characteristics.name = ?', 'Breakfast').references(:characteristic).count
    #   data_by_health_group_hash[health_group.name]["Lunch"] = health_group_recipes.includes(:characteristics).where('characteristics.name = ?', 'Lunch').references(:characteristic).count
    #   data_by_health_group_hash[health_group.name]["Dinner"] = health_group_recipes.includes(:characteristics).where('characteristics.name = ?', 'Dinner').references(:characteristic).count
    #   data_by_health_group_hash[health_group.name]["Snack"] = health_group_recipes.includes(:characteristics).where('characteristics.name = ?', 'Snack').references(:characteristic).count    
    #   data_by_health_group_hash[health_group.name]["Dessert"] = health_group_recipes.includes(:characteristics).where('characteristics.name = ?', 'Dessert').references(:characteristic).count    
    # end
    # return data_by_health_group_hash
  end

  def self.data_by_total
      today = Date.today
      beginning_of_week = today.at_beginning_of_week
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
    beginning_of_week = today.at_beginning_of_week
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

  def fetch_possible_review_conflicts
    possible_review_conflicts = {}
    possible_review_conflicts["basic_info"] = [ReviewConflict.new, ReviewConflict.new, ReviewConflict.new, ReviewConflict.new, ReviewConflict.new]
    possible_review_conflicts["ingredients"] =[]
    self.ordered_ingredients.each do |ingredient|
      possible_review_conflicts["ingredients"] << ReviewConflict.new 
    end
    possible_review_conflicts["steps"] =[]
    self.steps.each do |step|
      possible_review_conflicts["steps"] << ReviewConflict.new 
    end
    possible_review_conflicts["allergens"] =[]
    self.ingredients.each do |ingredient|
      possible_review_conflicts["allergens"] << ReviewConflict.new 
    end
    possible_review_conflicts["health_groups"] = ReviewConflict.new
    possible_review_conflicts["categories"] = ReviewConflict.new
    possible_review_conflicts["marketing_items"]= []
    self.marketing_items.each do |marketing_item|
      possible_review_conflicts["marketing_items"] << ReviewConflict.new 
    end
    return possible_review_conflicts
  end

  def self.all_in_review
    recipes_in_review = []
    self.where(completed: true).where(live_recipe: false).each do|recipe|
      if recipe.quality_reviews.count >= 1
        recipes_in_review << recipe
      end
    end
    return recipes_in_review
  end

  def self.all_not_reviewed_yet
    recipes_not_reviewed = []
    self.where(completed: true).each do |recipe|
      if recipe.quality_reviews.count < 1
        recipes_not_reviewed << recipe 
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
  #   binding.pry
  # end

end
