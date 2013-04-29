class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    #further edit profile to add address and children info
    edit_user_registration_path

    # user_path is the named route for GET /users/:id corresponding to users#show
    # current_user is defined by Devise
    #user_path(current_user)
  end
end
