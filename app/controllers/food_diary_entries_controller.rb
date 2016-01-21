# == Schema Information
#
# Table name: food_diary_entries
#
#  id            :integer          not null, primary key
#  food_diary_id :integer
#  consumed_at   :datetime
#  food_item     :string(255)
#  location      :string(255)
#  note          :text
#  created_at    :datetime
#  updated_at    :datetime
#

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
    clean_date_form
    @food_diary_entry = FoodDiaryEntry.new(food_diary_entry_params)
    
    respond_to do |format|
      if @food_diary_entry.save
        format.html { redirect_to @food_diary, notice: 'Food diary entry was successfully created.' }
        format.json { render :show, status: :created, location: @food_diary_entry }
        format.js
      else
        format.html { render :new }
        format.json { render json: @food_diary_entry.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /food_dairy/:food_diary_id/food_diary_entries/1
  # PATCH/PUT /food_dairy/:food_diary_id/food_diary_entries/1.json
  def update

    clean_date_form

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
     @food_diary_entry_id = @food_diary_entry.id
    @food_diary_entry.destroy
    respond_to do |format|
      format.html { redirect_to @food_diary, notice: 'Food diary entry was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private

    # datetimepicker format comes back incorrect, should fix on front end and not clean data here
    def clean_date_form
      params[:food_diary_entry][:consumed_at] = params[:food_diary_entry][:consumed_at].gsub(%r{(.*)/(.*)/(.*)}, '\2/\1/\3') + " EST"
    end

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
