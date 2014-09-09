class RecipeStepsController < ApplicationController
  before_action :set_recipe_step, only: [:show, :edit, :update, :destroy]
  # GET /recipe_steps
  # GET /recipe_steps.json
  # def index
  #   @recipe_steps = RecipeStep.all
  #   # params sent from allergens_ingredients index 
  #   @recipe_id = params["recipe_id"]
  #   @recipe = Recipe.find(@recipe_id.to_i)
  # end

  # GET /recipe_steps/1
  # GET /recipe_steps/1.json
  def show
  end

  # GET /recipe_steps/new
  def new
    @recipe_step = RecipeStep.new
    # set recipe_id sent from ingredients_recipe index form remote true
    @recipe_id = params["recipe_id"]
    @recipe = Recipe.find(@recipe_id)
    @ingredients = @recipe.ingredients_recipes
  end

  # POST /recipe_steps
  # POST /recipe_steps.json
  def create
    params["recipe_step"]["ingredients_recipe_ids"] = params["recipe_step"]["ingredients_recipe_ids"].reject! { |c| c.empty? }
    @recipe_step = RecipeStep.new(recipe_step_params)
    respond_to do |format|
      if @recipe_step.save
        format.html { redirect_to @recipe_step, notice: 'Recipe step was successfully created.' }
        format.json { render :show, status: :created, location: @recipe_step }
        ## to show preview of steps
        @recipe = Recipe.find(params["recipe_step"]["recipe_id"])
        ### should sort by position
        @steps = @recipe.recipe_steps
        # for ingredients to select for next step
        @ingredients = @recipe.ingredients_recipes
        # for adding next step
        @recipe_step = RecipeStep.new
        # for hidden form of next step
        @recipe_id = @recipe.id
        # for allergen form 
        @ingredient = @recipe.ingredients.first
        # recipe ingredients that are already tagged with allergens
        @ingredients_tagged = @recipe.ingredients_tagged
        # recipe ingredients that are not tagged with allergens yet
        @ingredients_not_tagged = @recipe.ingredients_not_tagged
        @top_allergens = Allergen.first(15)
        @all_allergens = Allergen.order(:name).map(&:name)
        if @ingredient.suggested_allergens
          @suggested_allergens = @ingredient.suggested_allergens     
        end 
        format.js
      else
        format.html { render :new }
        format.json { render json: @recipe_step.errors, status: :unprocessable_entity }
      end
    end
  end

  # when sortable list is adjusted, it calls this method to save
  def sort
    params[:steps].each_with_index do |id, index|
      RecipeStep.find(id).update(position: index+1)
      # Faq.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end
  # # POST /recipe_steps
  # # POST /recipe_steps.json
  # def create_and_add
  #   @recipe_step = RecipeStep.new(recipe_step_params)

  #   respond_to do |format|
  #     if @recipe_step.save
  #       format.html { redirect_to @recipe_step, notice: 'Recipe step was successfully created.' }
  #       format.json { render :show, status: :created, location: @recipe_step }
  #       format.js
  #     else
  #       format.html { render :new }
  #       format.json { render json: @recipe_step.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # GET /recipe_steps/1/edit
  def edit
    @recipe_id = params["recipe_id"]
    @recipe = Recipe.find(@recipe_id)
    @ingredients = @recipe.ingredients
  end


  # PATCH/PUT /recipe_steps/1
  # PATCH/PUT /recipe_steps/1.json
  def update
    respond_to do |format|
      if @recipe_step.update(recipe_step_params)
        format.html { redirect_to @recipe_step, notice: 'Recipe step was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe_step }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @recipe_step.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipe_steps/1
  # DELETE /recipe_steps/1.json
  def destroy
    @recipe_step.destroy
    respond_to do |format|
      format.html { redirect_to recipe_steps_url, notice: 'Recipe step was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe_step
      @recipe_step = RecipeStep.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_step_params
      params.require(:recipe_step).permit(:step_number, :directions, :recipe_id, :ingredients_recipe_ids => [])
    end
end
