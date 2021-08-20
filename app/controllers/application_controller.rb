class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    resource.class.to_s.eql?("Administrator") ? admin_user_details_path : users_mypage_path(current_user.id)
  end

  def after_sign_out_path_for(resource)
    resource.eql?(:administrator) ? new_admin_session_path : new_user_session_path
  end


  def routes_not_found!
    /^\/users/.match?(request.path) ? users_redirect : admin_redirect
  end

  private

  def users_redirect
    user_id = current_user&.id
    case request.path
    when users_sign_up_confirm_path
      redirect_to new_user_registration_path
    when user_id && confirm_users_mypage_path(user_id)
      redirect_to edit_users_mypage_path(user_id)
    when user_id && password_update_users_mypage_path(user_id)
      redirect_to password_users_mypage_path(user_id)
    else
      redirect_to new_user_session_path
    end
  end

  def admin_redirect
    redirect_to new_admin_session_path
  end
end
