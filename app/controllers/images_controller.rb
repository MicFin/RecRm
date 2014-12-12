class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]
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
    binding.pry
    @image = @imageable.images.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    binding.pry
    @image = @imageable.images.new(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to @imageable, notice: 'image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
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
        format.html { redirect_to @image, notice: 'image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
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
      binding.pry
      params.require(:image).permit(:image_type, :title, :imageable_d, :imageable_type)
    end
end
