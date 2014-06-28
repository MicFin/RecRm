class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

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

  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
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

  # GET /recipes/1/edit
  def edit
    @recipe = Recipe.find(params[:id])
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

  # POST /recipes
  # POST /recipes.json
  def create
    # remove empty strings from the characteristic_ids array, these are from the internal placeholder label
    params["recipe"]["characteristic_ids"].reject! { |characteristic_id| characteristic_id.empty? }
    # convert remaining strings in array to integers, again, not sure why they are coming over as strings
    params["recipe"]["characteristic_ids"].map!{ |characteristic_id| characteristic_id.to_i }
    # create new recipe and relationship to characteristics
    @recipe = Recipe.new(recipe_params)
    respond_to do |format|
      if @recipe.save
        binding.pry
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
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
    respond_to do |format|
      if @recipe.update(recipe_params)
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:name, :taste, :cook_time, :prep_time, :difficulty, :course, :age_group, :target_group, :dietitian_id, :characteristic_ids => [])
    end
end
