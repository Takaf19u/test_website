class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    resource.class.to_s.eql?("Administrator") ? admin_user_details_path : new_user_session_path
  end

  def after_sign_out_path_for(resource)
    resource.eql?(:administrator) ? new_admin_session_path : new_user_session_path
  end
end
