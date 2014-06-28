class AllergensIngredientsController < ApplicationController
  # skip_before_action :verify_authenticity_token
  before_action :set_allergens_ingredient, only: [:show, :edit, :update, :destroy]


  # GET /allergens_ingredients
  # GET /allergens_ingredients.json
  def index
    @allergens_ingredients = AllergensIngredient.all
    # set recipe_id sent as param from recipe create method 
    @recipe_id = params["recipe_id"]
    @recipe = Recipe.find(@recipe_id.to_i)
  end

  # GET /allergens_ingredients/1
  # GET /allergens_ingredients/1.json
  def show
  end

  # GET /allergens_ingredients/new
  def new
    @allergens_ingredient = AllergensIngredient.new
    @allergens_ingredient.build_allergen
    @allergen = Allergen.new 
  end

  # GET /allergens_ingredients/1/edit
  def edit
  end

  # POST /allergens_ingredients
  # POST /allergens_ingredients.json
  def create
    @allergens_ingredient = AllergensIngredient.new(allergens_ingredient_params)
    respond_to do |format|
      if @allergens_ingredient.save
        # need to redirect somwhere........
        format.html { redirect_to @allergens_ingredient, notice: 'allergens_ingredient was successfully created.' }
        format.json { render :show, status: :created, location: @allergens_ingredient }
        # we are responding to JS right now, create.js.erb
        format.js 
      else
        format.html { render :new }
        format.json { render json: @allergens_ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /allergens_ingredients/1
  # PATCH/PUT /allergens_ingredients/1.json
  def update
    respond_to do |format|
      if @allergens_ingredient.update(allergens_ingredient_params)
        format.html { redirect_to @allergens_ingredient, notice: 'allergens_ingredient was successfully updated.' }
        format.json { render :show, status: :ok, location: @allergens_ingredient }
      else
        format.html { render :edit }
        format.json { render json: @allergens_ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /allergens_ingredients/1
  # DELETE /allergens_ingredients/1.json
  def destroy
    @allergens_ingredient.destroy
    respond_to do |format|
      format.html { redirect_to allergens_ingredients_url, notice: 'allergens_ingredient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_allergens_ingredient
      @allergens_ingredient = AllergensIngredient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def allergens_ingredient_params
      params.require(:allergens_ingredient).permit(:amount, :amount_unit, :recipe_id )
    end
end
