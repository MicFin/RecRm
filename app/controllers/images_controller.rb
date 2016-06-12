# == Schema Information
#
# Table name: images
#
#  id             :integer          not null, primary key
#  image_type     :string(255)
#  imageable_id   :integer
#  imageable_type :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  title          :string(255)
#  image          :string(255)
#  position       :integer          default(0)
#

class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :crop, :destroy]
  before_filter :load_imageable, only: [:index, :new, :create]


  # GET /images
  # GET /images.json
  def index
    @images = @imageable.images
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    
    @image = @imageable.images.new
  end

  # GET /dietitians/1/images/2/crop
  def crop

  end

  # GET /images/1/edit
  def edit
  end


  # POST /images
  # POST /images.json
  def create
    
    @image = @imageable.images.new(image_params)

    respond_to do |format|
      if @image.save
        if params[:image][:image].present?
          render :crop
        else
          format.html { redirect_to @imageable, notice: 'image was successfully created.' }
          format.json { render :show, status: :created, location: @image }
        end
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update

    respond_to do |format|
      if @image.update(image_params)
        if @image.crop_x.present?
          
          render :crop
        else
          
          format.html { redirect_to dietitian_authenticated_root_path, notice: 'image was successfully updated.' }
          format.json { render :show, status: :ok, location: @image }
        end

      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    def load_imageable
      klass = [Dietitian].detect { |c| params["#{c.name.underscore}_id"] }
      @imageable = klass.find(params["#{klass.name.underscore}_id"])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      
      params.require(:image).permit(:image_type, :title, :imageable_d, :imageable_type, :image, :crop_x, :crop_y, :crop_w, :crop_h, :crop_image, :remove_image, :position, :image_cache)
    end
end
