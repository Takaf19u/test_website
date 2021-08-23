# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  after_action :after_login, only: [:create]

  # GET /resource/sign_in
  def new
    # raise
    super
  end

  # POST /resource/sign_in
  def create
    self.resource = User.new(user_params)
    if resource.invalid?(:password)
      flash[:alert] = resource.errors.full_messages.join("\n")
      return redirect_to new_user_session_path
    end
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end


  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def after_login
    current_user.update(current_sign_in_at: Time.current) if user_signed_in?
  end
end
