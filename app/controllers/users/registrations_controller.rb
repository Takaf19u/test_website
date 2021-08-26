# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  after_action :after_login, only: [:create]
  # GET /resource/sign_up
  def new
    @user = User.new
    test = @user.build_user_detail
    test.build_user_notification
    # super
  end

  def confirm
    @user = User.new(user_params)
    @user.user_detail.phone_number = @user.user_detail.format_phone_number
    return render :new if @user.invalid?([:email_all_checks, :password_all_checks])
    @select_notice = params[:user][:user_detail_attributes][:user_notification_attributes]
  end

  # POST /resource
  def create
    if params[:back]
      @user = User.new(user_params)
      return render :new
    end
    configure_permitted_parameters
    build_resource(sign_up_params)
    return render :new if resource.invalid?([:email_all_checks, :password_all_checks])

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, user_detail_attributes: [ :name, :company_name, :department_name, :phone_number, user_notification_attributes: [ :other, :job ]])
   end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ user_detail_attributes: [ :name, :company_name, :department_name, :phone_number, user_notification_attributes: [ :other, :job ] ] ])
  end

  def after_login
    current_user.update(current_sign_in_at: Time.current) if user_signed_in?
  end
end
