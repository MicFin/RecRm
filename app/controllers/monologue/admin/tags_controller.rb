class Monologue::Admin::TagsController < Monologue::Admin::BaseController
  respond_to :html
  before_filter :load_tag, only: [:edit, :update]
  
  def index
    @tags = Monologue::Tag.default
    @authors = Monologue::User.order(:email)
  end

  def new
    @authors = Monologue::User.order(:email)
    @tag = Monologue::Tag.new
  end

  ## Preview a tag without saving.
  def preview
    # mockup our models for preview.
    @tag = Monologue::Tag.new tag_params
    @tag.user_id = monologue_current_user.id
    @tag.published_at = Time.zone.now
    # render it exactly as it would display when live.
    render "/monologue/tags/show", layout: Monologue::Config.layout || "/layouts/monologue/application"
  end

  def create
    
    @authors = Monologue::User.order(:email)
    @tag = Monologue::Tag.new tag_params
    @tag.user_id = monologue_current_user.id
    if @tag.save
      prepare_flash_and_redirect_to_edit()
    else
      render :new
    end
  end

  def edit
    @authors = Monologue::User.order(:email)
  end

  def update
    
    @authors = Monologue::User.order(:email)
    if @tag.update(tag_params)
      prepare_flash_and_redirect_to_edit()
    else
      render :edit
    end
  end

  def destroy
    tag = Monologue::Tag.find(params[:id])
    if tag.destroy
      redirect_to admin_tags_path, notice:  I18n.t("monologue.admin.tags.delete.removed")
    else
      redirect_to admin_tags_path, alert: I18n.t("monologue.admin.tags.delete.failed")
    end
  end

private
  def load_tag
    @tag = Monologue::Tag.find(params[:id])
  end

  # def prepare_flash_and_redirect_to_edit
  #   if @tag.published_in_future? && ActionController::Base.perform_caching
  #     flash[:warning] = I18n.t("monologue.admin.tags.#{params[:action]}.saved_with_future_date_and_cache")
  #   else
  #     flash[:notice] =  I18n.t("monologue.admin.tags.#{params[:action]}.saved")
  #   end
  #   redirect_to edit_admin_tag_path(@tag)
  # end

  def tag_params
    params.require(:tag).permit(:name, :tag_category)
  end
end
 