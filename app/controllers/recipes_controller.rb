class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy,:edit_recipe_group]
  before_action :set_characteristic_forms, only: [:new, :edit]
  before_action :set_characteristic_display, only: [:edit_recipe_group, :show]
  autocomplete :ingredient, :name
  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.all
  end

  def dietitian_recipes_index
    @recipes = Recipe.where(dietitian_id: current_dietitian.id)
  end
  # GET /recipes/1
  # GET /recipes/1.json
  def show
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
    binding.pry
  end

  # POST /recipes
  # POST /recipes.json
  def create
    # remove empty strings from the characteristic_ids array, these are from the placeholder label on the form
    params["recipe"]["characteristic_ids"].reject! { |characteristic_id| characteristic_id.empty? }
    # convert remaining strings in array to integers, not sure why they are coming over as strings
    params["recipe"]["characteristic_ids"].map!{ |characteristic_id| characteristic_id.to_i }
    @recipe = Recipe.new(recipe_params)
    # assign dieititan to recipe
    @recipe.dietitian_id = current_dietitian.id
    respond_to do |format|
      # if recipe saves correctly
      if @recipe.save
        # if html send to ingredients_index index 
        # pass recipe_id to ingredients_recipe index method
        format.html { redirect_to ingredients_recipes_path(recipe_id: @recipe.id), notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        set_characteristic_forms
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
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

    def set_characteristic_display
      @cook_time = @recipe.characteristics.where(category: "Cook Time").first
      @prep_time = @recipe.characteristics.where(category: "Prep Time").first
      @difficulty = @recipe.characteristics.where(category: "Difficulty").first
      @courses = @recipe.characteristics.where(category: "Course")
      @age_groups = @recipe.characteristics.where(category: "Age Group")
      @scenarios = @recipe.characteristics.where(category: "Scenario")
      @holidays = @recipe.characteristics.where(category: "Holiday")
      @cultures = @recipe.characteristics.where(category: "Culture")
      binding.pry
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
