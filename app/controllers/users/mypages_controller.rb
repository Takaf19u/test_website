class Users::MypagesController < ApplicationController

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
  end

  def update
    @user = User.find(current_user.id)
    if params[:back]
      @user = User.new(user_params)
      return render :edit
    end
    @user.update!(user_params)
    redirect_to mypage_path
  end

  private

  def user_params
    params.require(:user).permit(:email, user_detail_attributes: [ :name, :company_name, :department_name, :phone_number])
   end
end
