# frozen_string_literal: true

class Administrators::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    @errors = flash[:errors].present? ? flash[:errors] : ""
    super
  end

  # POST /resource/sign_in
  def create
    admin = Administrator.new(admin_params)
    unless admin.valid?
      errors = { email: admin.errors.full_messages_for(:email).first,
                 password: admin.errors.full_messages_for(:password).first
               }
      return redirect_to new_administrator_session_path, flash: { errors: errors }
    end
    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private

  def admin_params
    params.require(:administrator).permit(:email, :password)
  end
end
