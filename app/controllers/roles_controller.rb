# == Schema Information
#
# Table name: roles
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  resource_id   :integer
#  resource_type :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]

  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.where(resource_type: nil)
  end

  # GET /roles/assignments
  def assignments
    @dietitians = Dietitian.all
    @users = User.all
    @admin_users = AdminUser.all
    @roles = Role.where(resource_type: nil).map(&:name).uniq
  end

  # GET /roles/assignments/edit/:id
  # :id = dietitian_id
  def edit_assignments
    @dietitian = Dietitian.find(params[:id])
    @roles = Role.where(resource_type: nil).map(&:name).uniq
  end

  # GET /roles/assignments/update/:id
  # :id = dietitian_id
  def update_assignments
    @dietitian = Dietitian.find(params[:id])
    @dietitian.roles = []
    new_roles_array = params[:roles]
    new_roles_array.each do |role|
      @dietitian.add_role role
    end
    respond_to do |format|
      if @dietitian.save
        format.html { redirect_to roles_assignments_path, notice: 'Role assignments were successfully updated.' }
      else
        format.html { render :update_assignments }
      end
    end
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
  end

  # GET /roles/new
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles
  # POST /roles.json
  def create
    @role = Role.new(role_params)

    respond_to do |format|
      if @role.save
        format.html { redirect_to roles_path, notice: 'Role was successfully created.' }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to roles_path, notice: 'Role was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url, notice: 'Role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:name, :resource_id, :resource_type)
    end
end
