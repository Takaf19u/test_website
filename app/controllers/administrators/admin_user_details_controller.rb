class Administrators::AdminUserDetailsController < ApplicationController
  layout "admin/application"
  before_action :authenticate_administrator!

  def index
    flash.now[:alert] = I18n.t("errors.messages.correct_current_sign_in_at") unless User.correct_current_sign_in_at?(params[:q])
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(id: "DESC")
    @users_count = @users.size
    @users = @users.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_user_details_path, flash: { message: I18n.t("message.delete_success") }
  end
end
