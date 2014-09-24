class ReviewConflictsController < ApplicationController
  before_filter :set_review_conflict, only: [:update, :edit]

  def new

  end

  def edit

  end

  def create
    binding.pry
    @review_conflict = ReviewConflict.new(review_conflict_params)
    @recipe = Recipe.find(params[:recipe_id])
    respond_to do |format|
      if @review_conflict.save
        format.html { redirect_to new_review_conflict_path(review_conflict_id: @review_conflict.id), notice: 'review_conflict was successfully created.' }
        format.json { render :show, status: :created, location: @review_conflict }
        format.js
      else
        format.html { render :new }
        format.json { render json: @review_conflict.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /review_conflicts/:id/review_conflict/:id
  # PATCH/PUT /articles/:id/review_conflict/:id.json
  def update

  end

  # POST articles/:id/review_conflicts
  def index

  end

  private

  def review_conflict_params
    params.require(:review_conflict).permit(:first_reviewer_id, :second_reviewer_id, :third_reviewer_id, :risk_level, :category, :item, :issue, :resolved, :review_stage, :quality_review_id, :first_suggestion, :second_suggestion, :third_suggestion)
  end

  def set_review_conflict
    binding.pry
    @review_conflict = ReviewConflict.find(params[:id])
  end


end