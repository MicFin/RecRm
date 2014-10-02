class IngredientsRecipesController < ApplicationController
  include IngredientsRecipesHelper
  # skip_before_action :verify_authenticity_token
  before_action :set_ingredients_recipe, only: [:show, :edit, :update, :destroy]
  before_action :set_options, only: [:new, :edit, :create]

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
    @all_ingredients = Ingredient.order(:name).map(&:name)
    @recipe_id = params["recipe_id"]
    get_units!
    @units = @units
    @recipe = Recipe.find(@recipe_id)
    @all_ingredient_display_names = IngredientsRecipe.all_ingredient_display_names
    @steps_by_group = @recipe.steps_by_group
    respond_to do |format|
      format.js { render "new" and return}
      @ingredients = @recipe.ordered_ingredients
      format.html { render "new_ingredient_page" and return}
    end
  end
  
  # POST /ingredients_recipes
  # POST /ingredients_recipes.json
  def create
    #mark as main or optional
    if params["ingredients_recipe"]["options"] == "main"
      params["ingredients_recipe"]["main_ingredient"] = true
      params["ingredients_recipe"].delete("options")
    elsif params["ingredients_recipe"]["options"] == "optional"
      params["ingredients_recipe"]["optional_ingredient"] = true
      params["ingredients_recipe"].delete("options")
    end
    # create new ingredients recipe with params
    @ingredients_recipe = IngredientsRecipe.new(ingredients_recipe_params)

    # finds of creates the ingredient and saves as the ingredients_recipe's ingredient_id
    @ingredients_recipe.find_or_create_ingredient(params["ingredients_recipe"]["ingredient_attributes"]["name"])
    # recipe id
    @recipe_id = params["recipe_id"]
    # set ingredients_recipe to recipe_id
    @ingredients_recipe.recipe_id = @recipe_id
    # recipe
    @recipe = Recipe.find(@recipe_id)
    # set position to last 
    @ingredients_recipe.position = @recipe.ingredients_recipes.count
    # update creation stage
    if @recipe.creation_stage < 2
      @recipe.creation_stage = 2
      @recipe.save
    end
    respond_to do |format|
      if @ingredients_recipe.save
        format.html { redirect_to @ingredients_recipe, notice: 'Recipe ingredient was successfully created.' }
        format.json { render :show, status: :created, location: @ingredients_recipe }
        # for updating ingredients_list
        @ingredients = @recipe.ordered_ingredients
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
    @ingredient_id = params[:id]
    @ingredients_recipe = IngredientsRecipe.find(@ingredient_id)
    @ingredient = @ingredients_recipe.ingredient
    get_units!
    @units = @units
    @recipe_id = params["recipe_id"]
    @all_ingredient_display_names = IngredientsRecipe.all_ingredient_display_names
    @all_ingredients = Ingredient.order(:name).map(&:name)
  end

  # PATCH/PUT /ingredients_recipes/1
  # PATCH/PUT /ingredients_recipes/1.json
  def update
    #mark as main or optional and set opposite to false or if none are selected than set both false
    if params["ingredients_recipe"]["options"] == "main"
      params["ingredients_recipe"]["main_ingredient"] = true
      params["ingredients_recipe"].delete("options")
      params["ingredients_recipe"]["optional_ingredient"] = false
    elsif params["ingredients_recipe"]["options"] == "optional"
      params["ingredients_recipe"]["optional_ingredient"] = true
      params["ingredients_recipe"].delete("options")
      params["ingredients_recipe"]["main_ingredient"] = false
    else
      params["ingredients_recipe"]["optional_ingredient"] = false
      params["ingredients_recipe"]["main_ingredient"] = false
      params["ingredients_recipe"].delete("options")
    end
    # find or create shopping ingredient attached to recipe ingredient
    @ingredients_recipe.find_or_create_ingredient(params["ingredients_recipe"]["ingredient_attributes"]["name"])
    respond_to do |format|
      if @ingredients_recipe.update(ingredients_recipe_params)
        recipe_id = params["ingredients_recipe"]["recipe_id"].to_i
        format.html { redirect_to ingredients_recipes_path(recipe_id: recipe_id), notice: 'ingredients_recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @ingredients_recipe }
        @ingredient = @ingredients_recipe
        @ingredient_id = @ingredient.id
        @recipe_id = params["recipe_id"]
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
    @ingredient_id = @ingredients_recipe.id
    @ingredients = Recipe.find(@ingredients_recipe.recipe_id).ingredients_recipes    
    @ingredients_recipe.destroy
    respond_to do |format|
      format.html { redirect_to ingredients_recipes_url, notice: 'ingredients_recipe was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end


    # when sortable list is adjusted, it calls this method to save new orders
  def sort
    params[:ingredients_recipes].each_with_index do |id, index|
      IngredientsRecipe.find(id).update(position: index+1)
    end
    render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredients_recipe
      @ingredients_recipe = IngredientsRecipe.find(params[:id])
    end

    def set_options

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingredients_recipe_params
      params.require(:ingredients_recipe).permit(:amount, :amount_unit, :recipe_id, :optional_ingredient, :main_ingredient, :display_name, :position, :ingredient_attributes => [])
    end
end
