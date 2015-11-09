class FoodDiariesController < ApplicationController
  before_action :set_food_diary, only: [:show, :edit, :update, :destroy]

  # GET /food_diaries
  # GET /food_diaries.json
  def index
    @food_diaries = FoodDiary.all
  end

  # GET /food_diaries/1
  # GET /food_diaries/1.json
  def show

    @food_diary_entry = FoodDiaryEntry.new
  end

  # GET /food_diaries/new
  def new
    @food_diary = FoodDiary.new
  end

  # GET /food_diaries/1/edit
  def edit
  end

  # POST /food_diaries
  # POST /food_diaries.json
  def create
    @food_diary = FoodDiary.new(food_diary_params)

    respond_to do |format|
      if @food_diary.save
        format.html { redirect_to @food_diary, notice: 'Food diary was successfully created.' }
        format.json { render :show, status: :created, location: @food_diary }
      else
        format.html { render :new }
        format.json { render json: @food_diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /food_diaries/1
  # PATCH/PUT /food_diaries/1.json
  def update
    respond_to do |format|
      if @food_diary.update(food_diary_params)
        format.html { redirect_to @food_diary, notice: 'Food diary was successfully updated.' }
        format.json { render :show, status: :ok, location: @food_diary }
      else
        format.html { render :edit }
        format.json { render json: @food_diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_diaries/1
  # DELETE /food_diaries/1.json
  def destroy
    @food_diary.destroy
    respond_to do |format|
      format.html { redirect_to food_diaries_url, notice: 'Food diary was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food_diary
      @food_diary = FoodDiary.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_diary_params
      params.require(:food_diary).permit(:user_id)
    end
end
