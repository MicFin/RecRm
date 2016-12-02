class GuestUsersController < ApplicationController
  before_action :set_guest_user, only: [:show, :edit, :update, :destroy]

  # GET /guest_users
  # GET /guest_users.json
  def index
    @users = User.client_accounts.order_by_last_sign_in
  end

  # GET /guest_users/1
  # GET /guest_users/1.json
  def show
  end

  # GET /guest_users/new
  def new
    @guest_user = GuestUser.new
  end

  # GET /guest_users/1/edit
  def edit
  end

  # POST /guest_users
  # POST /guest_users.json
  def create
    @guest_user = GuestUser.new(guest_user_params)

    respond_to do |format|
      if @guest_user.save
        format.html { redirect_to dietitian_unauthenticated_root_path, notice: 'Thank you for contacting us!' }
        format.json { render :show, status: :created, location: @guest_user }
      else
        format.html { render :new }
        format.json { render json: @guest_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guest_users/1
  # PATCH/PUT /guest_users/1.json
  def update
    respond_to do |format|
      if @guest_user.update(guest_user_params)
        format.html { redirect_to @guest_user, notice: 'Guest user was successfully updated.' }
        format.json { render :show, status: :ok, location: @guest_user }
      else
        format.html { render :edit }
        format.json { render json: @guest_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guest_users/1
  # DELETE /guest_users/1.json
  def destroy
    @guest_user.destroy
    respond_to do |format|
      format.html { redirect_to guest_users_url, notice: 'Guest user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guest_user
      @guest_user = GuestUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guest_user_params
      params.require(:guest_user).permit(:first_name, :last_name, :phone_number, :email_address, :title, :company, :purpose, :help)
    end
end
