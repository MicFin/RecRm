class Monologue::Admin::PostsController < Monologue::Admin::BaseController
  respond_to :html
  before_filter :load_post, only: [:edit, :update]
  
  def index
    @posts = Monologue::Post.fetch_all_work_in_progress
    @completed_posts = Monologue::Post.fetch_all_completed
    @authors = Monologue::User.order(:email)
  end

  def new
    @authors = Monologue::User.order(:email)
    @post = Monologue::Post.new
  end

  ## Preview a post without saving.
  def preview
    # mockup our models for preview.
    @post = Monologue::Post.new post_params
    @post.user_id = monologue_current_user.id
    @post.published_at = Time.zone.now
    # render it exactly as it would display when live.
    render "/monologue/posts/show", layout: Monologue::Config.layout || "/layouts/monologue/application"
  end

  def create
    
    @authors = Monologue::User.order(:email)
    @post = Monologue::Post.new post_params
    @post.user_id = monologue_current_user.id
    if @post.save
      prepare_flash_and_redirect_to_edit()
    else
      render :new
    end
  end

  def edit
    @authors = Monologue::User.order(:email)
  end

  def update
    
    find_or_create_tags 
    
    @authors = Monologue::User.order(:email)
    if @post.update(post_params)
      prepare_flash_and_redirect_to_edit()
    else
      render :edit
    end
  end

  def destroy
    post = Monologue::Post.find(params[:id])
    if post.destroy
      redirect_to admin_posts_path, notice:  I18n.t("monologue.admin.posts.delete.removed")
    else
      redirect_to admin_posts_path, alert: I18n.t("monologue.admin.posts.delete.failed")
    end
  end

private

  def find_or_create_tags

    if params[:post][:tags_major_persona]
      tags_array = params[:post][:tags_major_persona].split(",")
      tags_array.each do |tag_name|
        tag = Monologue::Tag.where(name: tag_name).where(tag_category: "major persona").first_or_create
        if params[:post][:tag_ids]
          params[:post][:tag_ids].push(tag.id)
        else
          params[:post][:tag_ids] = []
          params[:post][:tag_ids].push(tag.id)
        end
      end
      params[:post].delete "tags_major_persona"
    end
    if params[:post][:tags_sub_persona]
      tags_array = params[:post][:tags_sub_persona].split(",")
      tags_array.each do |tag_name|
        tag = Monologue::Tag.where(name: tag_name).where(tag_category: "sub persona").first_or_create
        if params[:post][:tag_ids]
          params[:post][:tag_ids].push(tag.id)
        else
          params[:post][:tag_ids] = []
          params[:post][:tag_ids].push(tag.id)
        end
      end
      params[:post].delete "tags_sub_persona"
    end
    if params[:post][:tags_theme]
      tags_array = params[:post][:tags_theme].split(",")
      tags_array.each do |tag_name|
        tag = Monologue::Tag.where(name: tag_name).where(tag_category: "theme").first_or_create
        if params[:post][:tag_ids]
          params[:post][:tag_ids].push(tag.id)
        else
          params[:post][:tag_ids] = []
          params[:post][:tag_ids].push(tag.id)
        end
      end
      params[:post].delete "tags_theme"
    end
  end

  def load_post
    @post = Monologue::Post.find(params[:id])
  end

  def prepare_flash_and_redirect_to_edit
    if @post.published_in_future? && ActionController::Base.perform_caching
      flash[:warning] = I18n.t("monologue.admin.posts.#{params[:action]}.saved_with_future_date_and_cache")
    else
      flash[:notice] =  I18n.t("monologue.admin.posts.#{params[:action]}.saved")
    end
    redirect_to edit_admin_post_path(@post)
  end

  def post_params
    params.require(:post).permit(:published, :tag_list,:title,:content,:url,:published_at, :nutrition_review_required, :culinary_review_required, :medical_review_required, :marketing_review_required, :editorial_initial_review_required, :final_sign_off_date, :author_id, :specs, :call_to_action_id, :nutrition_review_completed_at, :medical_review_completed_at, :culinary_review_completed_at, :marketing_review_completed_at, :editorial_initial_review_completed_at, :specs, :specs_completed_at, :marketing_review_complete, :nutrition_review_complete, :culinary_review_complete, :medical_review_complete, :editorial_initial_review_complete, :editorial_final_review_required, :editorial_final_review_complete, :editorial_final_review_completed_at, :editorial_initial_reviewer, :editorial_final_reviewer, :nutrition_reviewer_id, :culinary_reviewer_id, :medical_reviewer_id, :editorial_reviewer_id, :spec_author_id, :call_to_action_activated, :specs_completed, :medical_reviewer_id, :content_type, :public, :author_complete, :tag_ids => [])
  end
end
 