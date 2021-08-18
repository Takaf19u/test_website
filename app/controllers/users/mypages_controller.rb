class Users::MypagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(current_user.id)
  end

  def password
  end

  def edit
    @user = User.find(current_user.id)
  end

  def confirm
    @user = User.new(user_params)
    @user.id = current_user.id
    @user.user_detail.format_phone_number
    return render :edit if @user.invalid?
  end

  def update
    @user = current_user
    if params[:back]
      @user = User.new(user_params)
      return render :edit
    end

    if @user.update(user_params)
      redirect_to users_mypage_path(current_user.id)
    else
      render :edit
    end
  end

  def password_update
    if current_user.update_with_password(password_params)
      sign_in(current_user, bypass: true)
      redirect_to users_mypage_path(current_user.id)
    else
      render :password
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, user_detail_attributes: [ :name, :company_name, :department_name, :phone_number])
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end