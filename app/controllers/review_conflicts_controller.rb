class ReviewConflictsController < ApplicationController
  include CharacteristicsHelper
  include IngredientsRecipesHelper
  include PatientGroupsHelper
  before_filter :set_review_conflict, only: [:update, :edit, :select_reviewer, :assign_reviewer, :start_review_conflict, :accept_review_conflict, :decline_review_conflict, :edit_review_conflict]

  def new
  end

  def edit
    @quality_reviewable = Recipe.find(params[:recipe_id])
    @quality_review = QualityReview.find(params[:quality_review_id])
    @all_recipe_names = Recipe.all_recipe_names
    if @review_conflict.category == "Recipe Ingredient"
      @ingredient_changes_hash = @review_conflict.ingredient_changes_hash
    elsif @review_conflict.category == "Recipe Step"
      @step_changes_hash = @review_conflict.step_changes_hash
      @ingredients = @quality_reviewable.ordered_ingredients
    elsif @review_conflict.category == "Allergens"
      @allergens_changes_hash = @review_conflict.allergens_changes_hash
    elsif @review_conflict.category == "Health Groups"
      @health_groups_changes_array = @review_conflict.health_groups_changes_array
    elsif @review_conflict.category == "Recipe Categories"
      @recipe_categories_changes_array = @review_conflict.recipe_categories_changes_array
    else
      # nothing
    end
    @item = @review_conflict.item
    get_recipe_characteristics!
    @cook_times = @cook_times
    @prep_times = @prep_times
    @difficulties = @difficulties
    @serving_sizes = @serving_sizes
    get_units!
    @units = @units
    @all_ingredient_display_names = IngredientsRecipe.all_ingredient_display_names
    @all_ingredients = Ingredient.order(:name).map(&:name)
    # For ingredient allergens review conflict
    @top_allergens = Allergen.top_allergens.order(:name)
    @all_allergens = Allergen.common_allergens.map(&:name)
    # For health groups review conflict
    get_patient_groups!
    @diseases = @diseases
    @intolerances = @intolerances
    @allergies = @allergies
    @diets = @diets
     # For recipe categories review conflict
    get_recipe_characteristics!
    @meals = @meals
    @cultures = @cultures
    @courses = @courses
  end

  def create
    if params[:review_conflict][:category] == "Recipe Ingredient"
      params[:review_conflict][:first_suggestion] = "'#{params[:review_conflict][:first_suggestion][:amount]}' '#{params[:review_conflict][:first_suggestion][:unit]}' '#{params[:review_conflict][:first_suggestion][:display_name]}' '#{params[:review_conflict][:first_suggestion][:shopping_list_item]}' '#{params[:review_conflict][:first_suggestion][:options]}'"
    elsif params[:review_conflict][:category] == "Recipe Step"
      params[:review_conflict][:first_suggestion] = "#{params[:review_conflict][:first_suggestion][:step_group_name]} <3<* #{params[:review_conflict][:first_suggestion][:directions]} <3<* #{params[:review_conflict][:first_suggestion][:ingredients]}"
    elsif params[:review_conflict][:category] == "Allergens"
      ingredient = params[:review_conflict][:first_suggestion][:ingredient_name] 
      allergens = params[:review_conflict][:first_suggestion][:allergens]
      if params[:review_conflict][:first_suggestion][:common] == "true"
        common = "true"
      else
        common = "false"
      end
      params[:review_conflict][:first_suggestion] = ingredient + " <3<* " + common + " <3<* "
      allergens.each do |allergen|
        params[:review_conflict][:first_suggestion] += "#{allergen} <3<* "
      end
    elsif params[:review_conflict][:category] == "Health Groups"
      if params[:review_conflict][:first_suggestion] != nil
        health_groups = params[:review_conflict][:first_suggestion][:health_groups]
        params[:review_conflict][:first_suggestion] = ""
          health_groups.each do |health_group|
            params[:review_conflict][:first_suggestion] += "#{health_group} <3<* "
        end
      else
        params[:review_conflict][:first_suggestion] = ""
      end
    elsif params[:review_conflict][:category] == "Recipe Categories"
      if params[:review_conflict][:first_suggestion] != nil
        categories = params[:review_conflict][:first_suggestion][:categories]
        params[:review_conflict][:first_suggestion] = ""
        categories.each do |category|
          params[:review_conflict][:first_suggestion] += "#{category} <3<* "
        end
      else
        params[:review_conflict][:first_suggestion] = ""
      end
    end
    # create new review conflict
    @review_conflict = ReviewConflict.new(review_conflict_params)
    # add current dietitian as first reviewer
    @review_conflict.first_reviewer_id = current_dietitian.id
    # find quality review
    @quality_review = QualityReview.find(params[:quality_review_id])
    # connect review conflict to its quality review
    @review_conflict.quality_review_id = @quality_review.id
    # connect review conflict to its review stage
    @review_conflict.review_stage = 1
    # find qauality reviewable
    @quality_reviewable = Recipe.find(params[:recipe_id])
    respond_to do |format|
      if @review_conflict.save
        if ( params[:review_conflict][:category] == "Recipe Ingredient" )
          @ingredient_changes_hash = @review_conflict.ingredient_changes_hash
          @item = params[:review_conflict][:item]
        elsif (params[:review_conflict][:category] == "Recipe Step")
          @step_changes_hash = @review_conflict.step_changes_hash
          @item = params[:review_conflict][:item]
        elsif (params[:review_conflict][:category] == "Allergens")
          @allergens_changes_hash = @review_conflict.allergens_changes_hash
          @item = params[:review_conflict][:item]
        elsif (params[:review_conflict][:category] == "Health Groups")
          @health_groups_changes_array = @review_conflict.health_groups_changes_array
          @item = params[:review_conflict][:item]
        elsif (params[:review_conflict][:category] == "Recipe Categories")
          @recipe_categories_changes_array = @review_conflict.recipe_categories_changes_array
          @item = params[:review_conflict][:item]
        else
          @item = @review_conflict.item
        end
        @risk_level = @review_conflict.risk_level
        # add role of reviewer for this recipe and the dietitian assigned to do the review
        format.html { redirect_to dietitian_recipes_path(current_dietitian), notice: "Quality Review assigned."}
        format.json { render :show, status: :created, location: @review_conflict} 
        format.js
      else
        format.html { render :new }
        format.json { render json: @review_conflict.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /review_conflicts/:id/review_conflict/:id
  # PATCH/PUT /articles/:id/review_conflict/:id.json
  def update
    if params[:review_conflict][:category] == "Recipe Ingredient"
      params[:review_conflict][:first_suggestion] = "'#{params[:review_conflict][:first_suggestion][:amount]}' '#{params[:review_conflict][:first_suggestion][:unit]}' '#{params[:review_conflict][:first_suggestion][:display_name]}' '#{params[:review_conflict][:first_suggestion][:shopping_list_item]}' '#{params[:review_conflict][:first_suggestion][:options]}'"
      params[:review_conflict][:original_entry]  = @review_conflict.original_entry
    elsif params[:review_conflict][:category] == "Recipe Step"
      params[:review_conflict][:first_suggestion] = "#{params[:review_conflict][:first_suggestion][:step_group_name]} <3<* #{params[:review_conflict][:first_suggestion][:directions]} <3<* #{params[:review_conflict][:first_suggestion][:ingredients]}"
      params[:review_conflict][:original_entry]  = @review_conflict.original_entry
    elsif params[:review_conflict][:category] == "Allergens"
      ingredient = params[:review_conflict][:first_suggestion][:ingredient_name] 
      allergens = params[:review_conflict][:first_suggestion][:allergens]
      if params[:review_conflict][:first_suggestion][:common] == "true"
        common = "true"
      else
        common = "false"
      end
      params[:review_conflict][:first_suggestion] = ingredient + " <3<* " + common + " <3<* "
      allergens.each do |allergen|
        params[:review_conflict][:first_suggestion] += "#{allergen} <3<* "
      end
    elsif params[:review_conflict][:category] == "Health Groups"
      if params[:review_conflict][:first_suggestion] != nil
        health_groups = params[:review_conflict][:first_suggestion][:health_groups]
        params[:review_conflict][:first_suggestion] = ""
        health_groups.each do |health_group|
          params[:review_conflict][:first_suggestion] += "#{health_group} <3<* "
        end
      else
        params[:review_conflict][:first_suggestion] = ""
      end
    elsif params[:review_conflict][:category] == "Recipe Categories"
      if params[:review_conflict][:first_suggestion] != nil
        categories = params[:review_conflict][:first_suggestion][:categories]
        params[:review_conflict][:first_suggestion] = ""
        categories.each do |category|
          params[:review_conflict][:first_suggestion] += "#{category} <3<* "
        end
      else
        params[:review_conflict][:first_suggestion] = ""
      end
    else
    end
    # find qaulity reviewable
    @quality_reviewable = Recipe.find(params[:recipe_id])
    # find wuality review
    @quality_review = QualityReview.find(params[:quality_review_id])
    # set fields that could e hidden in form but are not changed by user
    params[:review_conflict][:first_reviewer_id] = @review_conflict.first_reviewer_id
    params[:review_conflict][:quality_review_id] = @review_conflict.quality_review_id
    params[:review_conflict][:review_stage] = @review_conflict.review_stage
    respond_to do |format|
      if @review_conflict.update(review_conflict_params)
        # add role of reviewer for this recipe and the dietitian assigned to do the review
        if ( @review_conflict.category == "Recipe Ingredient" )
          @ingredient_changes_hash = @review_conflict.ingredient_changes_hash
        elsif (@review_conflict.category == "Recipe Step")
          @step_changes_hash = @review_conflict.step_changes_hash
        elsif (@review_conflict.category == "Allergens")
          @allergens_changes_hash = @review_conflict.allergens_changes_hash
        elsif (@review_conflict.category == "Health Groups")
          @health_groups_changes_array = @review_conflict.health_groups_changes_array
        elsif (@review_conflict.category == "Recipe Categories")
          @recipe_categories_changes_array = @review_conflict.recipe_categories_changes_array
        end
        @risk_level = @review_conflict.risk_level
        @item = @review_conflict.item
        format.json { render :show, status: :created, location: @review_conflict} 
        format.js
      else
        format.html { render :new }
        format.json { render json: @review_conflict.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # POST articles/:id/review_conflicts
  def index

  end


  def select_reviewer
    @item = @review_conflict.item
    @quality_review = @review_conflict.quality_review
    @quality_reviewable = @quality_review.quality_reviewable
    @dietitians = Dietitian.all
    @recipe_id = params[:recipe_id]
    @recipe = @quality_reviewable
    @ingredients = @recipe.ordered_ingredients
    @steps_by_group = @recipe.steps_by_group
    @ingredients_tagged = @recipe.ingredients_tagged
    @ingredients_not_tagged = @recipe.ingredients_not_tagged
    @ingredients_allergens_hash = @recipe.fetch_ingredients_allergens_hash
    @health_groups_array = @recipe.fetch_health_groups_array
    @categories_array = @recipe.fetch_categories_array
    @marketing_items_by_group = @recipe.marketing_items_by_group
    @select_reviewer = true
    if ((@review_conflict.review_stage == 2) && (@review_conflict.item.include? "ingredient-"))
      @ingredient_changes_hash_two = @review_conflict.ingredient_changes_hash("second")
    end
  end

  def start_review_conflict
    if @review_conflict.review_stage == 1
      @suggestion = "review_conflict[second_suggestion]"
      @reviewer_notes = "review_conflict[second_reviewer_notes]"
    elsif @review_conflict.review_stage == 2
      @suggestion = "review_conflict[third_suggestion]"
      @reviewer_notes = "review_conflict[third_reviewer_notes]"
    else
    end
      ## for recipe preview
      @recipe = Recipe.find(params[:recipe_id])
      @ingredients = @recipe.ordered_ingredients
      @steps_by_group = @recipe.steps_by_group
      @ingredients_tagged = @recipe.ingredients_tagged
      @categories_array = @recipe.fetch_categories_array
      @health_groups_array = @recipe.fetch_health_groups_array
      @marketing_items_by_group = @recipe.marketing_items_by_group
      @item = @review_conflict.item
      if @item.include? "ingredient-"
        @ingredient_changes_hash = @review_conflict.ingredient_changes_hash
        if @review_conflict.review_stage == 2
          @ingredient_changes_hash_two = @review_conflict.ingredient_changes_hash("second")
        end
        render "review_conflicts/review_conflict_individuals/review_conflict_ingredient"
      elsif @item.include? "step-"    
        @step_changes_hash = @review_conflict.step_changes_hash
        @ingredients = @recipe.ordered_ingredients 
        if @review_conflict.review_stage == 2
        end
        render "review_conflicts/review_conflict_individuals/review_conflict_step"
      elsif @item.include? "allergen-"
        @allergens_changes_hash = @review_conflict.allergens_changes_hash
        if @review_conflict.review_stage == 2
        end
        render "review_conflicts/review_conflict_individuals/review_conflict_allergens"
      elsif @item.include? "health-groups" 
        @health_groups_changes_array = @review_conflict.health_groups_changes_array 
        if @review_conflict.review_stage == 2
        end
        render "review_conflicts/review_conflict_individuals/review_conflict_health_group"
      elsif @item.include? "recipe-categories"
        @recipe_categories_changes_array = @review_conflict.recipe_categories_changes_array
        if @review_conflict.review_stage == 2
        end
        render "review_conflicts/review_conflict_individuals/review_conflict_recipe_categories"
      elsif @item.include? "marketing-item-" 
        if @review_conflict.review_stage == 2
        end 
        render "review_conflicts/review_conflict_individuals/review_conflict_marketing_items"
      else
        get_recipe_characteristics!
        @cook_times = @cook_times
        @prep_times = @prep_times
        @difficulties = @difficulties
        @serving_sizes = @serving_sizes
        @all_recipe_names = Recipe.all_recipe_names
       render "review_conflicts/review_conflict_individuals/review_conflict_basic_info"
      end  
  end

  def accept_review_conflict
    binding.pry
    # make changes and save
    review_stage = @review_conflict.review_stage 
    if review_stage == 1
      @review_conflict.second_reviewer_notes = params[:review_conflict][:second_reviewer_notes]
      @review_conflict.second_suggestion = "ACCEPT FIRST SUGGESTION"
      suggestion = "first"
    elsif review_stage == 2
      binding.pry
      @review_conflict.third_reviewer_notes = params[:review_conflict][:third_reviewer_notes]
      # ## send which suggestion to accept
      
      if params[:suggestion] == "first"
        @review_conflict.third_suggestion = @review_conflict.first_suggestion
        suggestion = @review_conflict.first_suggestion
      elsif params[:suggestion] == "second"
        @review_conflict.third_suggestion = @review_conflict.second_suggestion
        suggestion = @review_conflict.second_suggestion
      else
        suggestion = params[:third_suggestion]
        @review_conflict.third_suggestion = suggestion
      end
    end
    binding.pry
    @review_conflict.resolved = true
    respond_to do |format|
      if @review_conflict.save
        # update item
        update_item_with_suggestion(suggestion, @review_conflict)
        # update quality review
        update_quality_review_status(@review_conflict)
        # return format
        format.html { redirect_to dietitian_recipes_path(current_dietitian), notice: 'Review was successfully accepted.' }
        format.json { render :show, status: :created, location: @review_conflict} 
      else
        format.html { render :new }
        format.json { render json: @review_conflict.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def decline_review_conflict
    # make changes and save
    if @review_conflict.review_stage == 1
      @review_conflict.second_reviewer_notes = params[:review_conflict][:second_reviewer_notes]
      @review_conflict.second_suggestion = "KEEP ORIGINAL, DECLINE FIRST SUGGESTION"
      @review_conflict.review_stage = 2
    elsif @review_conflict.review_stage == 2
      @review_conflict.third_reviewer_notes = params[:review_conflict][:third_reviewer_notes]
      @review_conflict.third_suggestion = "KEEP ORIGINAL"
      @review_conflict.resolved = true
      @review_conflict.save
      ## make no changes to item since suggestions were declined and update quality review status
      # update quality review
      update_quality_review_status(@review_conflict)
    end
    respond_to do |format|
      if @review_conflict.save
        format.html { redirect_to dietitian_recipes_path(current_dietitian), notice: 'Review was successfully accepted.' }
        format.json { render :show, status: :created, location: @review_conflict} 
      else
        format.html { render :new }
        format.json { render json: @review_conflict.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def edit_review_conflict
    ## update review stage and add second suggestion
    ## if stage 2 then save all info like accept review
    if @review_conflict.review_stage == 1
      if @review_conflict.item.include? "health-groups"  
        if params[:review_conflict][:second_suggestion] != nil
          health_groups = params[:review_conflict][:second_suggestion][:health_groups]
          params[:review_conflict][:second_suggestion] = ""
          health_groups.each do |health_group|
            params[:review_conflict][:second_suggestion] += "#{health_group} <3<* "
          end
        else
          params[:review_conflict][:second_suggestion] = ""
        end
        @review_conflict.second_suggestion = params[:review_conflict][:second_suggestion]
      elsif @review_conflict.item.include? "recipe-categories" 
        if params[:review_conflict][:second_suggestion] != nil
          categories = params[:review_conflict][:second_suggestion][:categories]
          params[:review_conflict][:second_suggestion] = ""
          categories.each do |category|
            params[:review_conflict][:second_suggestion] += "#{category} <3<* "
          end
        else
          params[:review_conflict][:second_suggestion] = ""
        end
        @review_conflict.second_suggestion = params[:review_conflict][:second_suggestion]
      elsif @review_conflict.item.include? "ingredient-"
        @review_conflict.second_suggestion = "'#{params[:review_conflict][:second_suggestion][:amount]}' '#{params[:review_conflict][:second_suggestion][:unit]}' '#{params[:review_conflict][:second_suggestion][:display_name]}' '#{params[:review_conflict][:second_suggestion][:shopping_list_item]}' '#{params[:review_conflict][:second_suggestion][:options]}'"
      elsif @review_conflict.item.include? "step-"
        @review_conflict.second_suggestion = "#{params[:review_conflict][:second_suggestion][:step_group_name]} <3<* #{params[:review_conflict][:second_suggestion][:directions]} <3<* #{params[:review_conflict][:second_suggestion][:ingredients]}"     
      elsif @review_conflict.item.include? "allergen-"
        ingredient = params[:review_conflict][:second_suggestion][:ingredient_name] 
        allergens = params[:review_conflict][:second_suggestion][:allergens]
        if params[:review_conflict][:second_suggestion][:common] == "true"
          common = "true"
        else
          common = "false"
        end
        params[:review_conflict][:second_suggestion] = ingredient + " <3<* " + common + " <3<* "
        allergens.each do |allergen|
          params[:review_conflict][:second_suggestion] += "#{allergen} <3<* "
        end
        @review_conflict.second_suggestion = params[:review_conflict][:second_suggestion]
      elsif @review_conflict.item.include? "marketing-item-"
        @review_conflict.second_suggestion = "'#{params[:review_conflict][:second_suggestion][:amount]}' '#{params[:review_conflict][:second_suggestion][:unit]}' '#{params[:review_conflict][:second_suggestion][:display_name]}' '#{params[:review_conflict][:second_suggestion][:shopping_list_item]}' '#{params[:review_conflict][:second_suggestion][:options]}'"  
      else
        @review_conflict.second_suggestion = params[:review_conflict][:second_suggestion]
      end  
      @review_conflict.second_reviewer_notes = params[:review_conflict][:second_reviewer_notes]
      @review_conflict.review_stage = 2
    elsif @review_conflict.review_stage = 2
      if @review_conflict.item.include? "health-groups"  
        if params[:review_conflict][:third_suggestion] != nil
          health_groups = params[:review_conflict][:third_suggestion][:health_groups]
          params[:review_conflict][:third_suggestion] = ""
          health_groups.each do |health_group|
            params[:review_conflict][:third_suggestion] += "#{health_group} <3<* "
          end
        else
          params[:review_conflict][:third_suggestion] = ""
        end
        @review_conflict.third_suggestion = params[:review_conflict][:third_suggestion]
      elsif @review_conflict.item.include? "recipe-categories" 
        if params[:review_conflict][:third_suggestion] != nil
          categories = params[:review_conflict][:third_suggestion][:categories]
          params[:review_conflict][:third_suggestion] = ""
          categories.each do |category|
            params[:review_conflict][:third_suggestion] += "#{category} <3<* "
          end
        else
          params[:review_conflict][:third_suggestion] = ""
        end
        @review_conflict.third_suggestion = params[:review_conflict][:third_suggestion]
      elsif @review_conflict.item.include? "ingredient-"
        @review_conflict.third_suggestion = "'#{params[:review_conflict][:third_suggestion][:amount]}' '#{params[:review_conflict][:third_suggestion][:unit]}' '#{params[:review_conflict][:third_suggestion][:display_name]}' '#{params[:review_conflict][:third_suggestion][:shopping_list_item]}' '#{params[:review_conflict][:third_suggestion][:options]}'"
      elsif @review_conflict.item.include? "step-"
        @review_conflict.third_suggestion = "#{params[:review_conflict][:third_suggestion][:step_group_name]} <3<* #{params[:review_conflict][:third_suggestion][:directions]} <3<* #{params[:review_conflict][:third_suggestion][:ingredients]}"     
      elsif @review_conflict.item.include? "allergen-"
        ingredient = params[:review_conflict][:third_suggestion][:ingredient_name] 
        allergens = params[:review_conflict][:third_suggestion][:allergens]
        if params[:review_conflict][:third_suggestion][:common] == "true"
          common = "true"
        else
          common = "false"
        end
        params[:review_conflict][:third_suggestion] = ingredient + " <3<* " + common + " <3<* "
        allergens.each do |allergen|
          params[:review_conflict][:third_suggestion] += "#{allergen} <3<* "
        end
        @review_conflict.third_suggestion = params[:review_conflict][:third_suggestion]
      elsif @review_conflict.item.include? "marketing-item-"
        @review_conflict.third_suggestion = "'#{params[:review_conflict][:third_suggestion][:amount]}' '#{params[:review_conflict][:third_suggestion][:unit]}' '#{params[:review_conflict][:third_suggestion][:display_name]}' '#{params[:review_conflict][:third_suggestion][:shopping_list_item]}' '#{params[:review_conflict][:third_suggestion][:options]}'"  
      else
        @review_conflict.third_suggestion = params[:review_conflict][:third_suggestion]
      end  

      @review_conflict.resolved = true
      @review_conflict.save
      # update item
      update_item_with_suggestion("third", @review_conflict)
      # update quality review
      update_quality_review_status(@review_conflict)
    end
    respond_to do |format|
      if @review_conflict.save
        format.html { redirect_to dietitian_recipes_path(current_dietitian), notice: 'Review was successfully accepted.' }
        format.json { render :show, status: :created, location: @review_conflict} 
      else
        format.html { render :new }
        format.json { render json: @review_conflict.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def assign_reviewer
    
    if params[:review_conflict][:second_reviewer_id]
      @review_conflict.second_reviewer_id = params[:review_conflict][:second_reviewer_id].to_i
    else       
      @review_conflict.third_reviewer_id = params[:review_conflict][:third_reviewer].to_i
    end
    respond_to do |format|
      if @review_conflict.save
      
        format.html {redirect_to dietitian_recipes_path(current_dietitian)}
      else
        format.html { render :select_reviewer }
        format.json { render json: @review_conflict.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private

  def update_quality_review_status(review_conflict)
    quality_review = review_conflict.quality_review
    if quality_review.conflicts_cleared? 
      quality_review.resolved = true
      quality_review.date_resolved_on = DateTime.now
      quality_review.save
      #close quality 
    else
      #do nothing
    end

  end

  def update_item_with_suggestion(suggestion, review_conflict)
      recipe = review_conflict.quality_review.quality_reviewable
      item = review_conflict.item
      binding.pry
      if item.include? "recipe-name"
          recipe.name = suggestion
          recipe.save
      elsif item.include? "prep-time"
          recipe.prep_time = suggestion
          recipe.save
      elsif item.include? "cook-time" 
          recipe.cook_time = suggestion
          recipe.save
      elsif item.include? "difficulty"
          recipe.difficulty = suggestion
          recipe.save
      elsif item.include? "serving-size" 
          recipe.serving_size = suggestion
          recipe.save
      elsif item.include? "ingredient-"
        update_ingredient(suggestion, item, review_conflict)
      elsif item.include? "step-"   
        update_step(suggestion, item, review_conflict)
      elsif item.include? "allergen-"
        update_allergen(suggestion, item, review_conflict)
      elsif item.include? "health-groups"  
        update_recipe(suggestion, item, review_conflict)
      elsif item.include? "recipe-categories"
        update_recipe(suggestion, item, review_conflict)
      elsif item.include? "marketing-item-"  
        update_marketing_item(suggestion, item, review_conflict)
      end 
  end

  def update_ingredient(suggestion, item, review_conflict)
    ingredient_id = item.split("-").last
    ingredient = IngredientsRecipe.find(ingredient_id)
    changes_hash = review_conflict.ingredient_changes_hash(suggestion)
    ingredient.amount = changes_hash[:amount]
    ingredient.amount_unit = changes_hash[:unit]
    ingredient.display_name = changes_hash[:display_name]
    if changes_hash[:options] == "main"
      ingredient.optional_ingredient = false
      ingredient.main_ingredient = true
    elsif changes_hash[:options] == "optional"
      ingredient.optional_ingredient = true
      ingredient.main_ingredient = false
    else
      ingredient.optional_ingredient = false
      ingredient.main_ingredient = false
    end
    ingredient.find_or_create_ingredient(changes_hash[:shopping_list_item])
    ingredient.save 
  end

  def update_step(suggestion, item, review_conflict)

    step_id = item.split("-").last
    step = RecipeStep.find(step_id)
    recipe = review_conflict.quality_review.quality_reviewable
    changes_hash = review_conflict.step_changes_hash(suggestion)

    step.group_name = changes_hash[:step_group_name] 

    step.directions = changes_hash[:directions]
 
    ingredients_array = JSON.parse changes_hash[:ingredients]
    step.ingredients_recipes.delete_all
    if ingredients_array.count > 0
      ingredients_array.each do |ingredient|
        step.ingredients_recipes << recipe.ingredient_with_full_name(ingredient)
      end
    end
    step.save 
  end

  def update_allergen(suggestion, item, review_conflict)
    ingredient_id = item.split("-").last
    ingredient = Ingredient.find(ingredient_id)
    changes_hash = review_conflict.allergens_changes_hash(suggestion)
    if changes_hash["common"] == true
      ingredient.common_allergen = true
    else
      ingredient.common_allergen = false
    end
    ingredient.allergens.delete_all
    if changes_hash["allergens"].count > 0
      changes_hash["allergens"].each do |allergen|
        ingredient.allergens << Allergen.find_or_create_allergen(allergen)
      end
    end
    ingredient.save 
  end

  def update_recipe(suggestion, item, review_conflict)
    recipe = review_conflict.quality_review.quality_reviewable
    if item == "health-groups"
      recipe.patient_groups.delete_all
      changes_array = review_conflict.health_groups_changes_array(suggestion)
      if changes_array.count > 0
        changes_array.each do |health_group|
          recipe.patient_groups << PatientGroup.where(name: health_group).first
        end
      end
    else
      recipe.characteristics.delete_all
      changes_array = review_conflict.recipe_categories_changes_array(suggestion)
      if changes_array.count > 0
        changes_array.each do |category|
          recipe.characteristics << Characteristic.where(name: category).first
        end
      end
    end
    recipe.save
  end


  def update_marketing_item(suggestion, item, review_conflict)
    item_id = item.split("-").last
    marketing_item = MarketingItem.find(item_id)
    if suggestion == "first"
      marketing_item.content = review_conflict.first_suggestion
    elsif suggestion == "second"
      marketing_item.content = review_conflict.second_suggestion
    else
      marketing_item.content = review_conflict.third_suggestion
    end
    marketing_item.save
  end


  def review_conflict_params
    params.require(:review_conflict).permit(:risk_level, :category, :item, :first_suggestion, :second_suggestion, :third_suggestion, :issue, :resolved, :quality_review_id, :first_reviewer_id, :second_reviewer_id, :third_reviewer_id, :review_stage, :first_reviewer_notes, :second_reviewer_notes, :third_reviewer_notes, :original_entry)
  end

  def set_review_conflict
  
    @review_conflict = ReviewConflict.find(params[:id])
  end


end