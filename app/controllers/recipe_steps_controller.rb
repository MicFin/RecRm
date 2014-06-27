class Recipe_stepsController < ApplicationController
  before_action :set_recipe_step, only: [:show, :edit, :update, :destroy]

  # GET /recipe_steps
  # GET /recipe_steps.json
  def index
    @recipe_steps = RecipeStep.all
  end

  # GET /recipe_steps/1
  # GET /recipe_steps/1.json
  def show
  end

  # GET /recipe_steps/new
  def new
    @recipe_step = RecipeStep.new
  end

  # GET /recipe_steps/1/edit
  def edit
  end

  # POST /recipe_steps
  # POST /recipe_steps.json
  def create
    @recipe_step = RecipeStep.new(recipe_step_params)

    respond_to do |format|
      if @recipe_step.save
        format.html { redirect_to @recipe_step, notice: 'recipe_step was successfully created.' }
        format.json { render :show, status: :created, location: @recipe_step }
      else
        format.html { render :new }
        format.json { render json: @recipe_step.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipe_steps/1
  # PATCH/PUT /recipe_steps/1.json
  def update
    respond_to do |format|
      if @recipe_step.update(recipe_step_params)
        format.html { redirect_to @recipe_step, notice: 'recipe_step was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe_step }
      else
        format.html { render :edit }
        format.json { render json: @recipe_step.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe_step
      @recipe_step = RecipeStep.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_step_params
      params.require(:recipe_step).permit(:step_number, :directions, :recipe_id)
    end
end
