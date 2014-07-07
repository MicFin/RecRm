class IngredientsRecipesController < ApplicationController
  # skip_before_action :verify_authenticity_token
  before_action :set_ingredients_recipe, only: [:show, :edit, :update, :destroy]
  before_action :set_units, only: [:new, :edit]

  # GET /ingredients_recipes
  # GET /ingredients_recipes.json
  def index
    @ingredients_recipes = IngredientsRecipe.all
    # set recipe_id sent as param from recipe create method 
    @recipe_id = params["recipe_id"]
    @recipe = Recipe.find(@recipe_id.to_i)
  end

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
    # need to decide where to pull this list from
  end

  # GET /ingredients_recipes/1/edit
  def edit
    @recipe = Recipe.find(params["recipe_id"])
    # need to decide where to pull this list from
  end

  # POST /ingredients_recipes
  # POST /ingredients_recipes.json
  def create
    # create new ingredients recipe with params
    @ingredients_recipe = IngredientsRecipe.new(ingredients_recipe_params)
    # set ingredient name to see if it exists yet
    ingredient_name = params["ingredients_recipe"]["ingredient_attributes"]["name"]
    # finds of creates the ingredient and saves as the ingredients_recipe's ingredient_id
    @ingredients_recipe.find_or_create_ingredient(ingredient_name)
    # respond to...
    respond_to do |format|
      if @ingredients_recipe.save
        format.html { redirect_to @ingredients_recipe, notice: 'ingredients_recipe was successfully created.' }
        format.json { render :show, status: :created, location: @ingredients_recipe }
        # we are responding to JS right now, create.js.erb
        format.js 
      else
        format.html { render :new }
        format.json { render json: @ingredients_recipe.errors, status: :unprocessable_entity }
        format.js
      end
    end
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

    def set_units
      @units = ["cup", "teaspoon", "tablespoon", "ounce", "pound", "fluid ounce", "gill", "pint", "quart" "gallon", "milliliter", "liter", "deciliter", "milligram", "gram", "kilogram", "pinch", "handful", "dash", "to taste", "bushel", "drop", "piece", "whole", "half", "slice", "cloves", "each", "as needed", "sprig", "dash", "once around the pot", "spear", "stalk", "splash", "dollop", "loaf", "square", "pat", "sheet", "wedge", "ear", "section"]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingredients_recipe_params
      params.require(:ingredients_recipe).permit(:amount, :amount_unit, :recipe_id )
    end
end
