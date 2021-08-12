class AdminUserDetailsController < ApplicationController
  layout 'admin/application'
  before_action :authenticate_administrator!

  def index
    @users = User.all.page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_user_details_path
  end

end
