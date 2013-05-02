class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    if current_user.addresses.empty? || current_user.children.empty?
      edit_user_registration_path
    else
      user_path(current_user)
    end
  end
end
