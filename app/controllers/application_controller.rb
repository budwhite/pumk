class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    if current_user.verified?
      user_path(current_user)
    else
      edit_user_registration_path
    end
  end
end
