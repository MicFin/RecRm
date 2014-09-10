class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:show, :edit, :update, :destroy]

  # # GET /ingredients
  # # GET /ingredients.json
  # def index
  #   @ingredients = Ingredient.all
  #   @recipe_id = params["id"]
  # end

  # # GET /ingredients/1
  # # GET /ingredients/1.json
  # def show
  # end

  # # GET /ingredients/new
  # def new
  #   @ingredient = Ingredient.new
  # end

  # GET /ingredients/1/edit
  def edit
    @allergens = Allergen.first(10)
    @suggested_allergens = @ingredient.suggested_allergens
    @recipe = Recipe.find(params[:recipe_id])
    @other_allergens = @ingredient.other_allergens
  end

  # # POST /ingredients
  # # POST /ingredients.json
  # def create
  #   @ingredient = Ingredient.new(ingredient_params)

  #   respond_to do |format|
  #     if @ingredient.save
  #       format.html { redirect_to @ingredient, notice: 'Ingredient was successfully created.' }
  #       format.json { render :show, status: :created, location: @ingredient }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @ingredient.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  def new_method
    binding.pry
  end

  # PATCH/PUT /ingredients/1
  # PATCH/PUT /ingredients/1.json
  def update
    params["ingredient"]["allergen_ids"] = params["ingredient"]["allergen_ids"].reject! { |c| c.empty? }
    # if ingredient is not tagged as its own allergen then tag it
    if @ingredient.allergens.where(name: @ingredient.name).count != 1
      # if it is a common allergen mark it
      if params["ingredient"]["common_allergen"]
        @ingredient.common_allergen = true 
        @allergen = Allergen.create(name: @ingredient.name, common_allergen: true)
        @allergen.common_allergen = true
        params["ingredient"].delete("common_allergen")
      else
        @allergen = Allergen.create(name: @ingredient.name) 
      end  
      @allergen.save!
      params["ingredient"]["allergen_ids"].push(@allergen.id)
    else
      # else add self-allergen to allergen array for update of new selects
      @allergen = Allergen.where(name: @ingredient.name).first
      params["ingredient"]["allergen_ids"].push(@allergen.id)
    end
    # recipe ID passed 
    @recipe_id = params["recipe_id"].to_i
    # find or create new allergen and add to allergen params
    if params["ingredient"]["extra_allergens"]
      params["ingredient"]["extra_allergens"].each do |allergen_name|
        added_allergen = Allergen.where(name: allergen_name).first 
        if added_allergen == nil
          added_allergen = Allergen.create(name: allergen_name, manual_enter: true)
        end
        params["ingredient"]["allergen_ids"].push(added_allergen.id)
      end
    end
    respond_to do |format|
      if @ingredient.update(ingredient_params)
       # redirect to list of recipe ingredients and allergens
        format.html { redirect_to allergens_ingredients_path(recipe_id: @recipe_id), notice: 'Ingredient was successfully updated.' }
        format.json { render :show, status: :ok, location: @ingredient }
        ## want it to go to the next one, and add to the right
        ## if last one then go to review
        @recipe = Recipe.find(@recipe_id)
        # for allergen form 
        if @recipe.ingredients_not_tagged.count >= 1
          @ingredient = @recipe.ingredients_not_tagged.first
          @tagging_done = false
          if @ingredient.suggested_allergens
            @suggested_allergens = @ingredient.suggested_allergens  
          end 
        else
          @tagging_done = true
        end
          # for patient group forms (needs to be available even when doing another ingredient)
          @allergies = PatientGroup.allergies
          @diseases = PatientGroup.diseases
          @intolerances = PatientGroup.intolerances
        # recipe ingredients that are already tagged with allergens
        @ingredients_tagged = @recipe.ingredients_tagged
        # recipe ingredients that are not tagged with allergens yet
        @ingredients_not_tagged = @recipe.ingredients_not_tagged
        @top_allergens = Allergen.first(15)
        @all_allergens = Allergen.order(:name).map(&:name)
   
        format.js 
      else
        format.html { render :edit }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  def review
    # create
  end
  
  # # DELETE /ingredients/1
  # # DELETE /ingredients/1.json
  # def destroy
  #   @ingredient.destroy
  #   respond_to do |format|
  #     format.html { redirect_to ingredients_url, notice: 'Ingredient was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient
      @ingredient = Ingredient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingredient_params
      params.require(:ingredient).permit(:name, :category, :common_allergen, :allergen_ids => [])
    end
end
