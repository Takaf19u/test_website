class AdminUserDetailsController < ApplicationController
  layout 'admin/application'
  before_action :authenticate_administrator!

  def index
    @users_count = User.all.size
    @users = User.all.page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_user_details_path, flash: { message: I18n.t("message.delete_user_success") }
  end

end
