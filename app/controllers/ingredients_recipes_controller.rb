class IngredientRecipesController < ApplicationController
  before_action :set_ingredient_recipe, only: [:show, :edit, :update, :destroy]

  # GET /ingredient_recipes
  # GET /ingredient_recipes.json
  def index
    @ingredient_recipes = IngredientRecipe.all
  end

  # GET /ingredient_recipes/1
  # GET /ingredient_recipes/1.json
  def show
  end

  # GET /ingredient_recipes/new
  def new
    @ingredient_recipe = IngredientRecipe.new
  end

  # GET /ingredient_recipes/1/edit
  def edit
  end

  # POST /ingredient_recipes
  # POST /ingredient_recipes.json
  def create
    @ingredient_recipe = IngredientRecipe.new(ingredient_recipe_params)

    respond_to do |format|
      if @ingredient_recipe.save
        format.html { redirect_to @ingredient_recipe, notice: 'ingredient_recipe was successfully created.' }
        format.json { render :show, status: :created, location: @ingredient_recipe }
      else
        format.html { render :new }
        format.json { render json: @ingredient_recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ingredient_recipes/1
  # PATCH/PUT /ingredient_recipes/1.json
  def update
    respond_to do |format|
      if @ingredient_recipe.update(ingredient_recipe_params)
        format.html { redirect_to @ingredient_recipe, notice: 'ingredient_recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @ingredient_recipe }
      else
        format.html { render :edit }
        format.json { render json: @ingredient_recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredient_recipes/1
  # DELETE /ingredient_recipes/1.json
  def destroy
    @ingredient_recipe.destroy
    respond_to do |format|
      format.html { redirect_to ingredient_recipes_url, notice: 'ingredient_recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient_recipe
      @ingredient_recipe = IngredientRecipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingredient_recipe_params
      params.require(:ingredient_recipe).permit(:name, :category)
    end
end
