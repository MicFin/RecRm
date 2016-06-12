  class KfConfigController < ApplicationController
    before_action :get_kf_config, only: [:edit, :update, :destroy]
    before_action :verify_admin

    def index
      # KfConfig.get_all("general.")
      @kf_configs = KfConfig.all
      @kf_config = KfConfig.new

    end

    def new
      @kf_config = KfConfig.new

    end

    def create

      @kf_config = KfConfig.new(kf_config_params)

      respond_to do |format|
        if @kf_config.save
          format.html { redirect_to kf_config_index_path, notice: 'Setting was successfully saved.' }
          # format.json { render :show, status: :created, location: @kf_config }
        else
          format.html { render :new }
          # format.json { render json: @kf_config.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit

    end

    def update
      # only updates the value
      if @kf_config.value != params[:kf_config][:value]
        @kf_config.value = params[:kf_config][:value]
        @kf_config.save
        redirect_to kf_config_index_path, notice: 'Setting has updated.'
      else
        redirect_to kf_config_index_path
      end
    end

    # DELETE /kf_config/:id
    def destroy
      @kf_config.destroy
      respond_to do |format|
        format.html { redirect_to kf_config_index_path, notice: 'Setting was successfully deleted.' }
      end
    end

    private

    def get_kf_config  
      @kf_config = KfConfig.find_by(var: params[:id]) || KfConfig.new(var: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kf_config_params
      params.require(:kf_config).permit(:var, :value, :display_name)
    end

    def verify_admin
      if !current_dietitian.has_role? "Admin Dietitian" 
        redirect_to dietitian_unauthenticated_root_path
      end
    end
  end
