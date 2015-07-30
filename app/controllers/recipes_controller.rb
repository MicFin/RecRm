class RecipesController < ApplicationController
	include CharacteristicsHelper
	include StepsHelper
	include IngredientsHelper
  include IngredientsRecipesHelper
  include PatientGroupsHelper
  
  ## might not need load marketing itemable
  before_action :set_recipe, only: [:show, :edit, :destroy, :review_recipe]
  before_action :set_characteristic_forms, only: [:new, :edit]
  before_action :set_characteristic_display, only: [:show, :review_recipe]
  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.last(250)
    respond_to do |format|
      format.html
      format.csv { send_data @recipes.to_csv }
      # format.xls { send_data @recipes.to_csv(col_sep: "\t") }
      format.xls
    end
    # respond_to do | format |  
    #   format.html # index.html.erb
    #   format.json { render :json => @recipes }
    #   format.xlsx {
    #     # xlsx_package = Recipe.to_xlsx
    #     xlsx_package = Recipe.to_xlsx :header_style => {
    #         :bg_color => "00", 
    #         :fg_color => "FF", 
    #         :sz => 16, 
    #         :alignment => { :horizontal => :center }
    #       }
    #       # :style => {:border => Axlsx::STYLE_THIN_BORDER}

    #       sheet = xlsx_package.workbook.worksheets.first  

    #       timestamp = xlsx_package.workbook.styles.add_style :format_code => "MM-DD-YYYY", :border => Axlsx::STYLE_THIN_BORDER
        
    #       sheet.col_style 1, timestamp, :row_offset => 1
    
    #     begin 
    #       temp = Tempfile.new("recipes.xlsx") 
    #       xlsx_package.serialize temp.path
    #       # send_file temp.path, :filename => "recipes.xlsx", :type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    #       send_data xlsx_package.to_stream.read, :filename => 'recipes.xlsx', :type=> "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    #     ensure
    #       temp.close 
    #       temp.unlink
    #     end
    #   }  
    # end
  end

  ###notes
  ## this method and view is being used as the dietitian dashboard right now, it should be moved to a home controller or another controller
  def dietitian_recipes_index
    if current_dietitian.has_role? "Marketing Reviewer"
      @all_completed_recipes = Recipe.where(completed: true).limit(250).order("created_at").reverse
    else
      @all_completed_recipes = Recipe.where(completed: true).limit(20).order("created_at").reverse
    end
    @recipes = Recipe.where(dietitian_id: current_dietitian.id, completed: true).order("created_at").reverse
    @incomplete_recipes = current_dietitian.incomplete_recipes
    @recipe_reviews_to_assign = []
    if current_dietitian.has_role? "Admin Dietitian"
      @recipes_need_original_review = Recipe.all_need_original_review
      @recipes_need_first_tier_review = Recipe.all_need_first_tier_review
      @recipes_need_second_tier_review = Recipe.all_need_second_tier_review
      @recipes_in_second_tier_review = Recipe.all_in_second_tier_review
      @recipes_in_first_tier_review = Recipe.all_in_first_tier_review
      @all_live_recipes = Recipe.all_live_recipes
      # @assign_review_conflicts_hash = ReviewConflict.assign_by_risk_level
      # @review_conflicts_in_review_hash = ReviewConflict.in_review_by_risk_level
      @resolved_quality_revews = QualityReview.where(resolved: true)
      # @resolved_review_conflicts = ReviewConflict.where(resolved: true)
      @test_recipes = Recipe.where(dietitian_id: 11).where(:created_at => Date.today.at_beginning_of_week.beginning_of_day..Date.tomorrow.end_of_day)
    end
    @incomplete_quality_reviews = current_dietitian.incomplete_quality_reviews
    # @incomplete_review_conflicts = ReviewConflict.assigned_to_dietitian(current_dietitian.id)
  end
  # GET /recipes/1
  # GET /recipes/1.json

	# def show #old
	# 	# make sure to call this first
	# 	@recipe = Recipe.find(params[:id])

	# 	# ingredients_helper
	# 	get_ingredients!

	# 	# steps_helper
	# 	get_recipe_steps!

	# 	# characteristics_helper
	# 	get_recipe_characteristics!

	# 	@recipe.ingredient_list = @recipe_ingredients
	# 	@recipe.step_list = @recipe_steps
	# 	@recipe.cook_time = @cook_time
	# 	@recipe.prep_time = @prep_time
	# 	@recipe.difficulty = @difficulty
	# 	@recipe.courses = @courses
	# 	@recipe.age_groups = @age_groups
	# 	@recipe.meals = @meals
	# 	@recipe.cultures = @cultures

	# end

  def show
    @recipe_id = params[:id]
    @recipe = Recipe.find(@recipe_id)
    @ingredients = @recipe.ordered_ingredients
    @steps_by_group = @recipe.steps_by_group
    @ingredients_tagged = @recipe.ingredients_tagged
    @ingredients_not_tagged = @recipe.ingredients_not_tagged
    @ingredients_allergens_hash = @recipe.fetch_ingredients_allergens_hash
    @health_groups_array = @recipe.fetch_health_groups_array
    @categories_array = @recipe.fetch_categories_array
    @marketing_items_by_group = @recipe.marketing_items_by_group
  end
  # GET /recipes/:id/review_recipe
  # GET /recipes/:id/review_recipe.json
  def review_recipe
    get_recipe_characteristics!
    @cook_times = @cook_times
    @prep_times = @prep_times
    @difficulties = @difficulties
    @serving_sizes = @serving_sizes
    get_units!
    @units = @units
    @ingredients = @recipe.ordered_ingredients
    @ingredients_count = @ingredients.count
    @steps_by_group = @recipe.steps_by_group
    @recipe_id = @recipe.id
    if @recipe.creation_stage < 7
      @recipe.creation_stage = 7
      @recipe.save
    end
    @all_ingredient_display_names = IngredientsRecipe.all_ingredient_display_names
    @all_ingredients = Ingredient.order(:name).map(&:name)
    @ingredients_tagged = @recipe.ingredients_tagged
    @ingredients_not_tagged = @recipe.ingredients_not_tagged
    @health_groups = @recipe.patient_groups
    @categories = @recipe.characteristics
    @marketing_items_by_group = @recipe.marketing_items_by_group
    # @allergies = @recipe.allergies
    # @diseases = @recipe.diseases
    # @intolerances = @recipe.intolerances

    # @marketing_items = @recipe.marketing_items
  end

  def complete_recipe
    @recipe = Recipe.find(params[:id])
    @recipe.completed = true
    @recipe.save
    redirect_to dietitian_recipes_path(current_dietitian)
  end


  # GET /recipes/new
  def new
    @recipe = Recipe.new
   # characteristics_helper
    get_recipe_characteristics!
    @cook_times = @cook_times
    @prep_times = @prep_times
    @difficulties = @difficulties
    @serving_sizes = @serving_sizes
    @all_recipe_names = Recipe.all_recipe_names
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    # assign dieititan to recipe
    @recipe.dietitian_id = current_dietitian.id
    @recipe.creation_stage = 1
    respond_to do |format|
      # if recipe saves correctly
      if @recipe.save
        format.html { redirect_to ingredients_recipes_path(recipe_id: @recipe.id), notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
        @recipe_id = @recipe.id
        # set recipe_id sent from ingredients_recipe index form remote true
        format.js
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_patient_groups
    @recipe = Recipe.find(params[:id])
    if @recipe.creation_stage < 4
      @recipe.creation_stage = 4
      @recipe.save
    end
    get_patient_groups!
    @diseases = @diseases
    @intolerances = @intolerances
    @allergies = @allergies
    @diets = @diets
    @recipe_id = @recipe.id
    # for preview
    @health_groups = @recipe.patient_groups 
    @categories = @recipe.characteristics
    respond_to do |format|
      format.js {render "edit_patient_groups" and return}
      format.html {render "edit_patient_groups_page"}
    end
  end

  def update_patient_groups
    @recipe = Recipe.find(params["recipe_id"])
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to review_recipe_path(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
        @recipe_id = params["recipe_id"]
        format.js
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_recipe_categories
    @recipe_id = params[:id]
    @recipe = Recipe.find(@recipe_id)
    if @recipe.creation_stage < 5
      @recipe.creation_stage = 5
      @recipe.save
    end
    get_recipe_characteristics!
    @meals = @meals
    @cultures = @cultures
    @courses = @courses
    # for preview
    @health_groups = @recipe.patient_groups 
    @categories = @recipe.characteristics
    respond_to do |format|
      format.js {render "edit_recipe_categories" and return}
      format.html {render "edit_recipe_categories_page" and return}
    end
  end

  def update_recipe_categories
    @recipe = Recipe.find(params[:id])
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to review_recipe_path(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
        @recipe_id = params[:id]
        format.js
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end
  # def create
  #   # remove empty strings from the characteristic_ids array, these are from the placeholder label on the form
  #   params["recipe"]["characteristic_ids"].reject! { |characteristic_id| characteristic_id.empty? }
  #   # convert remaining strings in array to integers, not sure why they are coming over as strings
  #   params["recipe"]["characteristic_ids"].map!{ |characteristic_id| characteristic_id.to_i }
  #   @recipe = Recipe.new(recipe_params)
  #   # assign dieititan to recipe
  #   @recipe.dietitian_id = current_dietitian.id
  #   respond_to do |format|
  #     # if recipe saves correctly
  #     if @recipe.save
  #       # if html send to ingredients_index index 
  #       # pass recipe_id to ingredients_recipe index method
  #       format.html { redirect_to ingredients_recipes_path(recipe_id: @recipe.id), notice: 'Recipe was successfully created.' }
  #       format.json { render :show, status: :created, location: @recipe }
  #     else
  #       set_characteristic_forms
  #       format.html { render :new }
  #       format.json { render json: @recipe.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # def select_health_groups
  #   @allergies = PatientGroup.allergies
  #   @diseases = PatientGroup.diseases
  #   @intolerances = PatientGroup.intolerances
  # end

  # def add_health_groups
  #   respond_to do |format|
  #     if @recipe.update(recipe_params)
  #       format.html { redirect_to review_recipe_path(@recipe), notice: 'Recipe was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @recipe }
  #       # we want it to add to right and go to select meal_info
  #       format.js
  #     else
  #       set_characteristic_forms
  #       format.html { render :edit }
  #       format.json { render json: @recipe.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # def select_meal_info
  #   @courses = PatientGroup.allergies
  #   @meals = PatientGroup.diseases
  #   @culture = PatientGroup.intolerances
  # end

  # def add_meal_info
  #   respond_to do |format|
  #     if @recipe.update(recipe_params)
  #       format.html { redirect_to review_recipe_path(@recipe), notice: 'Recipe was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @recipe }
  #       # we want it to add to right and go to marketing new
  #       format.js
  #     else
  #       set_characteristic_forms
  #       format.html { render :edit }
  #       format.json { render json: @recipe.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # GET /recipes/1/edit
  def edit
    get_recipe_characteristics!
    @cook_times = @cook_times
    @prep_times = @prep_times
    @difficulties = @difficulties
  end

  def edit_recipe_group
    @allergies = PatientGroup.safe_allergy_groups(@recipe.allergens)
    @diseases = PatientGroup.safe_disease_groups(@recipe.allergens)
    @intolerances = PatientGroup.safe_intolerance_groups(@recipe.allergens)
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUdT /recipes/1.json
  def update
    @recipe = Recipe.find(params[:id])
    respond_to do |format|
      if @recipe.update(recipe_params)
        ### notice how this redirects to review recipe
        format.html { redirect_to review_recipe_path(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def recipe_data
    if current_dietitian.has_role? "Admin Dietitian"
      @recipe_data_by_total = Recipe.data_by_total
      @recipe_data_by_dietitian = Recipe.data_by_dietitian
      @recipe_data_by_health_group = Recipe.data_by_health_group
    else
      redirect_to dietitian_recipes_path(current_dietitian)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    ### make as global helper method because also used in marketing_items_controller
    def set_characteristic_display

    end

    def set_characteristic_forms

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # need to change :image_url to :avatar when paperclip is working
    def recipe_params
      params.require(:recipe).permit(:image_url, :avatar, :name, :description, :dietitian_id, :cook_time, :prep_time, :serving_size, :difficulty, :complete, :live_recipe, :characteristic_ids => [], :patient_group_ids => [])
    end
end
