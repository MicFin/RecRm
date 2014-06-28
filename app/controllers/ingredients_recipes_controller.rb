class IngredientsRecipesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_ingredients_recipe, only: [:show, :edit, :update, :destroy]


  # GET /ingredients_recipes
  # GET /ingredients_recipes.json
  def index
    @ingredients_recipes = IngredientsRecipe.all
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
  end

  # GET /ingredients_recipes/1/edit
  def edit
  end

  # POST /ingredients_recipes
  # POST /ingredients_recipes.json
  def create
    @ingredients_recipe = IngredientsRecipe.new(ingredients_recipe_params)

    respond_to do |format|
      if @ingredients_recipe.save
        format.html { redirect_to @ingredients_recipe, notice: 'ingredients_recipe was successfully created.' }
        format.json { render :show, status: :created, location: @ingredients_recipe }
        format.js 
      else
        format.html { render :new }
        format.json { render json: @ingredients_recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ingredients_recipes/1
  # PATCH/PUT /ingredients_recipes/1.json
  def update
    respond_to do |format|
      if @ingredients_recipe.update(ingredients_recipe_params)
        format.html { redirect_to @ingredients_recipe, notice: 'ingredients_recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @ingredients_recipe }
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
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredients_recipe
      @ingredients_recipe = IngredientsRecipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingredients_recipe_params
      params.require(:ingredients_recipe).permit(:amount, :amount_unit, )
    end
end
