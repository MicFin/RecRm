class ReviewConflictsController < ApplicationController
  before_filter :set_review_conflict, only: [:update, :edit]

  def new

  end

  def edit

  end

  def create

  end

  # PATCH/PUT /articles/:id/review_conflict/:id
  # PATCH/PUT /articles/:id/review_conflict/:id.json
  def update

  end

  # POST articles/:id/review_conflicts
  def index

  end

  private

  def review_conflict_params
    params.require(:review_conflict).permit(:passed, :dietitian_id, :recipe_id, :completed)
  end

  def set_review_conflict
    @review_conflict = ReviewConflict.find(params[:id])
  end


end