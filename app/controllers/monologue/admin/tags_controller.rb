class Monologue::Admin::TagsController < Monologue::Admin::BaseController
  respond_to :html
  before_action :set_tag, only: [:edit, :update, :destroy]

  def show
    @tag = retrieve_tag
    if @tag
      @page = nil
      @posts = @tag.posts_with_tag
    else
      redirect_to :root ,notice: "No post found with label \"#{params[:tag]}\""
    end
  end

  def index
    @tags_grouped = Monologue::Tag.grouped_tags
    @tag = Monologue::Tag.new
    @authors = Monologue::User.order(:email)
  end

  def new
    # @authors = Monologue::User.order(:email)
    @tag = Monologue::Tag.new
  end

  def create
    # find_or_create_tags
    # @authors = Monologue::User.order(:email)
    @tag = Monologue::Tag.new tag_params
    # @tag.user_id = monologue_current_user.id
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
    if @tag.destroy
      redirect_to admin_tags_path, notice:  I18n.t("monologue.admin.tags.delete.removed")
    else
      redirect_to admin_tags_path, alert: I18n.t("monologue.admin.tags.delete.failed")
    end
  end



  private
  def retrieve_tag
    Monologue::Tag.where("lower(name) = ?", params[:tag].mb_chars.to_s.downcase).first
  end


  def set_tag
    @tag = Monologue::Tag.find(params[:id])
  end

  def prepare_flash_and_redirect_to_edit
    flash[:notice] =  "Tag saved!"
    redirect_to edit_admin_tag_path(@tag)
  end

  def tag_params
    params.require(:tag).permit(:name, :content_type, :tag_category)
  end  
end
