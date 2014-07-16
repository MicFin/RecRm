class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:show, :edit, :update, :destroy]
  autocomplete :allergen, :name
  # GET /ingredients
  # GET /ingredients.json
  def index
    @ingredients = Ingredient.all
    @recipe_id = params["id"]
  end

  # GET /ingredients/1
  # GET /ingredients/1.json
  def show
  end

  # GET /ingredients/new
  def new
    @ingredient = Ingredient.new
  end

  # GET /ingredients/1/edit
  def edit
    @allergens = Allergen.first(10)
    @recipe = Recipe.find(params[:recipe_id])
    @other_allergens = @ingredient.other_allergens
  end

  # POST /ingredients
  # POST /ingredients.json
  def create
    @ingredient = Ingredient.new(ingredient_params)

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to @ingredient, notice: 'Ingredient was successfully created.' }
        format.json { render :show, status: :created, location: @ingredient }
      else
        format.html { render :new }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ingredients/1
  # PATCH/PUT /ingredients/1.json
  def update
    # if ingredient is not marked as its own allergen 
    if @ingredient.allergens.where(name: @ingredient.name).count != 1
      # create allergen and add to ingredient allergens param
      allergen = Allergen.create(name: @ingredient.name)
      allergen.save!
      params["ingredient"]["allergen_ids"].push(allergen.id)
    else
      # else add self-allergen to allergen array
      allergen = Allergen.where(name: @ingredient.name).first
      params["ingredient"]["allergen_ids"].push(allergen.id)
    end
    # recipe ID passed from allergens ingredients index add allergy to ingredient button
    @recipe_id = params["ingredient"]["recipe_id"].to_i
    # delete recipe ID from the params before saving ingredient
    params["ingredient"].delete("recipe_id")
    # delete input field for new allergens from params
    params["ingredient"].delete("allergen")
    # find or create new allergen and add to allergen params
    if params["extra_allergens"]
      params["extra_allergens"].each do |allergen_name|
        allergen = Allergen.find_or_create_by(name: allergen_name)
        params["ingredient"]["allergen_ids"].push(allergen.id)
      end
    end
    respond_to do |format|
      if @ingredient.update(ingredient_params)
       # redirect to list of recipe ingredients and allergens
        format.html { redirect_to allergens_ingredients_path(recipe_id: @recipe_id), notice: 'Ingredient was successfully updated.' }
        format.json { render :show, status: :ok, location: @ingredient }
      else
        format.html { render :edit }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredients/1
  # DELETE /ingredients/1.json
  def destroy
    @ingredient.destroy
    respond_to do |format|
      format.html { redirect_to ingredients_url, notice: 'Ingredient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient
      @ingredient = Ingredient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingredient_params
      params.require(:ingredient).permit(:name, :category, :allergen_ids => [])
    end
end
