class RecipesController < ApplicationController
	include CharacteristicsHelper
	include StepsHelper
	include IngredientsHelper


  before_action :set_recipe, only: [:show, :edit, :update, :destroy,:edit_recipe_group, :review_recipe]
  before_action :set_characteristic_forms, only: [:new, :edit]
  before_action :set_characteristic_display, only: [:edit_recipe_group, :show, :review_recipe]
  autocomplete :ingredient, :name
  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.all
  end

  ## this method and view is being used as the dietitian dashboard right now, it should be moved to a home controller or another controller
  def dietitian_recipes_index
    @recipes = Recipe.where(dietitian_id: current_dietitian.id)
    @articles = Article.where(dietitian_id: current_dietitian.id)
  end
  # GET /recipes/1
  # GET /recipes/1.json

	# def show
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
	# 	@recipe.scenarios = @scenarios
	# 	@recipe.holidays = @holidays
	# 	@recipe.cultures = @cultures

	# 	gon.rabl as: 'recipe'
	# end

  # GET /review_recipe/1
  # GET /review_recipe/1.json
  def review_recipe
    @ingredients = @recipe.ingredients_recipes
    @allergies = @recipe.allergies
    @diseases = @recipe.diseases
    @intolerances = @recipe.intolerances
    @recipe_steps = @recipe.recipe_steps
  end


  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    # assign dieititan to recipe
    @recipe.dietitian_id = current_dietitian.id
    respond_to do |format|
      # if recipe saves correctly
      if @recipe.save
        # will need a html version with no JS
        # if html send to ingredients_index index 
        # pass recipe_id to ingredients_recipe index method
        format.html { redirect_to ingredients_recipes_path(recipe_id: @recipe.id), notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
        # will need to send recipe_id through this, insert a form field with the id into the page/template
        # want to send to ingrdients recipes controller new
        format.js
      else
        set_characteristic_forms
        format.html { render :new }
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

  def select_health_groups
    @allergies = PatientGroup.allergies
    @diseases = PatientGroup.diseases
    @intolerances = PatientGroup.intolerances
  end

  def add_health_groups
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to review_recipe_path(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
        # we want it to add to right and go to select meal_info
        format.js
      else
        set_characteristic_forms
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def select_meal_info
    @courses = PatientGroup.allergies
    @meals = PatientGroup.diseases
    @culture = PatientGroup.intolerances
  end

  def add_meal_info
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to review_recipe_path(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
        # we want it to add to right and go to marketing new
        format.js
      else
        set_characteristic_forms
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /recipes/1/edit
  def edit
    @allergies = PatientGroup.allergies
    @diseases = PatientGroup.diseases
    @intolerances = PatientGroup.intolerances
  end

  def edit_recipe_group
    @allergies = PatientGroup.safe_allergy_groups(@recipe.allergens)
    @diseases = PatientGroup.safe_disease_groups(@recipe.allergens)
    @intolerances = PatientGroup.safe_intolerance_groups(@recipe.allergens)
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to review_recipe_path(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        set_characteristic_forms
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    ### make as global helper method because also used in marketing_items_controller
    def set_characteristic_display
      @cook_time = @recipe.characteristics.where(category: "Cook Time").first
      @prep_time = @recipe.characteristics.where(category: "Prep Time").first
      @difficulty = @recipe.characteristics.where(category: "Difficulty").first
      @courses = @recipe.characteristics.where(category: "Course")
      @age_groups = @recipe.characteristics.where(category: "Age Group")
      @scenarios = @recipe.characteristics.where(category: "Scenario")
      @holidays = @recipe.characteristics.where(category: "Holiday")
      @cultures = @recipe.characteristics.where(category: "Culture")
    end

    def set_characteristic_forms
    # set instance variables for form fields
      @cook_times = Characteristic.where(category: "Cook Time")
      @prep_times = Characteristic.where(category: "Prep Time")
      @difficulties = Characteristic.where(category: "Difficulty")
      @courses = Characteristic.where(category: "Course")
      @age_groups = Characteristic.where(category: "Age Group")
      @scenarios = Characteristic.where(category: "Scenario")
      @holidays = Characteristic.where(category: "Holiday")
      @cultures = Characteristic.where(category: "Culture")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # need to change :image_url to :avatar when paperclip is working
    def recipe_params
      params.require(:recipe).permit(:image_url, :name, :description, :dietitian_id, :characteristic_ids => [], :patient_group_ids => [])
    end
end
