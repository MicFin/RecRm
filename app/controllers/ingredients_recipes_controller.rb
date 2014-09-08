class IngredientsRecipesController < ApplicationController
  include IngredientsRecipesHelper
  # skip_before_action :verify_authenticity_token
  before_action :set_ingredients_recipe, only: [:show, :edit, :update, :destroy]
  before_action :set_options, only: [:new, :edit]

  # GET /ingredients_recipes
  # GET /ingredients_recipes.json
  # def index
  #   @ingredients_recipes = IngredientsRecipe.all
  #   # set recipe_id sent as param from recipe create method 
  #   @recipe_id = params["recipe_id"]
  #   @recipe = Recipe.find(@recipe_id.to_i)
  # end

  # GET /ingredients_recipes/1
  # GET /ingredients_recipes/1.json
  def show
  end

  # GET /ingredients_recipes/new
  def new
    @ingredients_recipe = IngredientsRecipe.new
    @ingredients_recipe.build_ingredient
    @ingredient = Ingredient.new 
    # set recipe_id sent from ingredients_recipe index form remote true
    @recipe_id = params["recipe_id"]

  end

  # def create_and_add
  #   # create new ingredients recipe with params
  #   @ingredients_recipe = IngredientsRecipe.new(ingredients_recipe_params)
  #   # set ingredient name to see if it exists yet
  #   ingredient_name = params["ingredients_recipe"]["ingredient_attributes"]["name"]
  #   # finds of creates the ingredient and saves as the ingredients_recipe's ingredient_id
  #   @ingredients_recipe.find_or_create_ingredient(ingredient_name)
  #   # respond to...
  #   respond_to do |format|
  #     if @ingredients_recipe.save
  #       format.html { redirect_to @ingredients_recipe, notice: 'ingredients_recipe was successfully created.' }
  #       format.json { render :show, status: :created, location: @ingredients_recipe }
  #       # we are responding to JS right now, create_and_add.js.erb
  #       format.js 
  #       ### put on rigt side of screen
  #       ### want it to change form to a new ingredient
  #     else
  #       format.html { render :new }
  #       format.json { render json: @ingredients_recipe.errors, status: :unprocessable_entity }
  #       format.js
  #     end
  #   end
  # end
  
  # POST /ingredients_recipes
  # POST /ingredients_recipes.json
  def create
    # create new ingredients recipe with params
    @ingredients_recipe = IngredientsRecipe.new(ingredients_recipe_params)
    # set ingredient name to see if it exists yet
    ingredient_name  = params["ingredients_recipe"]["ingredient_attributes"]["name"]
    # finds of creates the ingredient and saves as the ingredients_recipe's ingredient_id
    @ingredients_recipe.find_or_create_ingredient(ingredient_name)
    @recipe_id = params["recipe_id"]
    @ingredients_recipe.recipe_id = @recipe_id
    binding.pry
    # respond to...
    respond_to do |format|
      if @ingredients_recipe.save
        format.html { redirect_to @ingredients_recipe, notice: 'Recipe ingredient was successfully created.' }
        format.json { render :show, status: :created, location: @ingredients_recipe }
        # we are responding to JS right now, create.js.erb
        @ingredients_recipe = IngredientsRecipe.new
        @ingredients_recipe.build_ingredient
        @ingredient = Ingredient.new 
        @all_ingredients = Ingredient.order(:name).map(&:name)
        @recipe_id = @recipe_id
        @ingredients = Recipe.find(@recipe_id).ingredients_recipes
        format.js 
      else
        format.html { render :new }
        format.json { render json: @ingredients_recipe.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # GET /ingredients_recipes/1/edit
  def edit
    @recipe = Recipe.find(params["recipe_id"])
  end

  # PATCH/PUT /ingredients_recipes/1
  # PATCH/PUT /ingredients_recipes/1.json
  def update
    respond_to do |format|
      if @ingredients_recipe.update(ingredients_recipe_params)
        recipe_id = params["ingredients_recipe"]["recipe_id"].to_i
        format.html { redirect_to ingredients_recipes_path(recipe_id: recipe_id), notice: 'ingredients_recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @ingredients_recipe }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @ingredients_recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredients_recipes/1
  # DELETE /ingredients_recipes/1.json
  def destroy
    @ingredients_recipe.destroy
    respond_to do |format|
      format.html { redirect_to ingredients_recipes_url, notice: 'ingredients_recipe was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredients_recipe
      @ingredients_recipe = IngredientsRecipe.find(params[:id])
    end

    def set_options
      @units = ["cup", "teaspoon", "tablespoon", "ounce", "pound", "fluid ounce", "gill", "pint", "quart", "gallon", "milliliter", "liter", "deciliter", "milligram", "gram", "kilogram", "pinch", "handful", "dash", "to taste", "bushel", "drop", "piece", "whole", "half", "slice", "cloves", "each", "as needed", "sprig", "dash", "once around the pot", "spear", "stalk", "splash", "dollop", "loaf", "square", "pat", "sheet", "wedge", "ear", "section"].sort
      get_ingredient_prep_options!
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingredients_recipe_params
      params.require(:ingredients_recipe).permit(:amount, :amount_unit, :recipe_id, :optional_ingredient, :main_ingredient, :display_name)
    end
end
