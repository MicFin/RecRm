class VersionsController < ApplicationController
  before_filter :verify_admin
  before_action :set_item_and_version, only: [:diff, :rollback, :destroy]

  def index
    if params[:item_type] == "User"
      @versions = UserVersion.where(item_type: 'User').order('created_at DESC')
    else
      @versions = UserVersion.order('created_at DESC')
    end
  end

  def deleted
    if params[:item_type] == "User"
      @versions = UserVersion.where(item_type: 'User', event: 'destroy').order('created_at DESC')
    else
      @versions = UserVersion.where(event: 'destroy').order('created_at DESC')
    end
  end
 
  def diff
    @versions = @version.item.versions.order('created_at DESC')
  end

  def rollback
    item = @version.reify
    item.save
    redirect_to versions_path({item_type: @version.item_type})
  end

  def destroy
  end

  def bringback
    version = UserVersion.find(params[:id])
    @item = version.reify
    @item.save
    version.delete
    redirect_to root_path, notice: 'The item was successfully brought back!'
  end

  private

   def set_item_and_version
    if params[:item_type] == "User"
      @user = User.find(params[:user_id])
      @version = @user.versions.find(params[:id])
    else
      @user = User.find(params[:user_id])
      @version = @user.versions.find(params[:id])
    end
   end


  private

  def verify_admin
    if !current_dietitian.has_role? "Admin Dietitian" 
      redirect_to dietitian_unauthenticated_root_path
    end
  end
end
