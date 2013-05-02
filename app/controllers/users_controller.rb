class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    if current_user.sign_in_count == 1
      unless session[:already_welcomed]
        flash.now[:success] = 'Welcome to PickUpMyKid.com!'
        session[:already_welcomed] = true
      end
    end
  end

  def update
    if current_user.update_attributes(params[:user])
      redirect_to user_path(current_user)
    else
      render 'devise/custom/registrations/edit'
    end
  end
end
