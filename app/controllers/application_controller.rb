class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    # user_path is the named route for GET /users/:id corresponding to users#show
    # current_user is defined by Devise
    user_path(current_user)
  end
end
