class Users::MypagesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :redirect_mypage, except: :index

  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def password
  end

  def edit
    @user = User.find(params[:id])
  end

  def confirm
    @user = User.new(user_params)
    @user.id = params[:id]
    @user.user_detail.phone_number = @user.user_detail.format_phone_number
    return render :edit if @user.invalid?(:email_all_checks)
    @select_notice = params[:user][:user_detail_attributes][:user_notification_attributes]
  end

  def update
    @user = current_user
    if params[:back]
      @user = User.new(user_params)
      return render :edit
    end

    @user.attributes = user_params
    if @user.save(context: :email_all_checks)
      redirect_to users_mypage_path(params[:id]), flash: { notice: I18n.t("message.complete_user_edit") }
    else
      render :edit
    end
  end

  def password_update
    if current_user.update_with_password(password_params)
      sign_in(current_user, bypass: true)
      redirect_to users_mypage_path(params[:id]), flash: { notice: I18n.t("message.complete_password") }
    else
      render :password
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, user_detail_attributes: [ :name, :company_name, :department_name, :phone_number, user_notification_attributes: [ :other, :job ]])
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end

  def redirect_mypage
    return redirect_to users_mypage_path(current_user.id) unless params[:id].eql?(current_user.id.to_s)
  end
end
