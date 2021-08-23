class Administrators::AdminUserDetailsController < ApplicationController
  layout "admin/application"
  before_action :authenticate_administrator!

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(id: "DESC")
    @users_count = @users.size
    @users = @users.page(params[:page]).per(10)
    # @current_sign_in_at = [params[:q][:current_sign_in_at_gteq], params[:q][:current_sign_in_at_lteq_end_of_day]]
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
