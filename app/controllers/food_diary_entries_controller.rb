class FoodDiaryEntriesController < ApplicationController
  before_action :set_food_diary_entry, only: [:show, :edit, :update, :destroy]
  before_action :set_food_diary, only: [:new, :edit, :update, :create, :destroy]
  # GET /food_dairy/:food_diary_id/food_diary_entries
  # GET /food_dairy/:food_diary_id/food_diary_entries.json
  def index
    @food_diary_entries = FoodDiaryEntry.all
  end

  # GET /food_dairy/:food_diary_id/food_diary_entries/1
  # GET /food_dairy/:food_diary_id/food_diary_entries/1.json
  def show
  end

  # GET /food_dairy/:food_diary_id/food_diary_entries/new
  def new
    @food_diary_entry = FoodDiaryEntry.new
  end

  # GET /food_dairy/:food_diary_id/food_diary_entries/1/edit
  def edit
  end

  # POST /food_dairy/:food_diary_id/food_diary_entries
  # POST /food_dairy/:food_diary_id/food_diary_entries.json
  def create
    @food_diary_entry = FoodDiaryEntry.new(food_diary_entry_params)

    respond_to do |format|
      if @food_diary_entry.save
        format.html { redirect_to @food_diary, notice: 'Food diary entry was successfully created.' }
        format.json { render :show, status: :created, location: @food_diary_entry }
      else
        format.html { render :new }
        format.json { render json: @food_diary_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /food_dairy/:food_diary_id/food_diary_entries/1
  # PATCH/PUT /food_dairy/:food_diary_id/food_diary_entries/1.json
  def update
    respond_to do |format|
      if @food_diary_entry.update(food_diary_entry_params)
        format.html { redirect_to @food_diary, notice: 'Food diary entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @food_diary_entry }
      else
        format.html { render :edit }
        format.json { render json: @food_diary_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_dairy/:food_diary_id/food_diary_entries/1
  # DELETE /food_dairy/:food_diary_id/food_diary_entries/1.json
  def destroy
    @food_diary_entry.destroy
    respond_to do |format|
      format.html { redirect_to @food_diary, notice: 'Food diary entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food_diary_entry
      @food_diary_entry = FoodDiaryEntry.find(params[:id])
    end

    def set_food_diary
      @food_diary = FoodDiary.find(params[:food_diary_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_diary_entry_params
      params.require(:food_diary_entry).permit(:food_diary_id, :consumed_at, :food_item, :location, :note)
    end
end
