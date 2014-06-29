class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy,:edit_recipe_step]
  before_action :set_characteristic_forms, only: [:new, :edit]
  autocomplete :ingredient, :name
  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.all
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
    @recipe = Recipe.find(params[:id])
    # set instance variables for recipe characteristics
    @cook_times = @recipe.characteristics.where(category: "Cook Time")
    @prep_times = @recipe.characteristics.where(category: "Prep Time")
    @difficulties = @recipe.characteristics.where(category: "Difficulty")
    @courses = @recipe.characteristics.where(category: "Course")
    @age_groups = @recipe.characteristics.where(category: "Age Group")
    @scenarios = @recipe.characteristics.where(category: "Scenario")
    @holidays = @recipe.characteristics.where(category: "Holiday")
    @cultures = @recipe.characteristics.where(category: "Culture")
    @ingredients = @recipe.ingredients
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    @ingredients_recipe = IngredientsRecipe.new
    @ingredients_recipe.build_ingredient
    @ingredient = Ingredient.new  
  end

  # GET /recipes/1/edit
  def edit
  end

  def edit_recipe_step
    @allergies = PatientGroup.allergies_no_other
    @diseases = PatientGroup.diseases_no_other
    @intolerances = PatientGroup.intolerances_no_other
  end

  # POST /recipes
  # POST /recipes.json
  def create
    # remove empty strings from the characteristic_ids array, these are from the placeholder label on the form
    params["recipe"]["characteristic_ids"].reject! { |characteristic_id| characteristic_id.empty? }
    # convert remaining strings in array to integers, not sure why they are coming over as strings
    params["recipe"]["characteristic_ids"].map!{ |characteristic_id| characteristic_id.to_i }
    # # create new recipe
    @recipe = Recipe.new(recipe_params)
    respond_to do |format|
      # if recipe saves correctly
      if @recipe.save
        # if html send to new ingredients_index index 
        # pass recipe_id to ingredients_recipe index method
        format.html { redirect_to ingredients_recipes_path(recipe_id: @recipe.id), notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    binding.pry
    respond_to do |format|
      if @recipe.update(recipe_params)
        binding.pry
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
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
    def recipe_params
      params.require(:recipe).permit(:name, :description, :dietitian_id, :characteristic_ids => [], :patient_group_ids => [])
    end
end
