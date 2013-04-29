class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def update
    # current_user already exists
    if current_user.update_attributes(params[:user])
      #set_flash_message :notice, :updated
      redirect_to user_path(current_user)
    else
      render 'devise/custom/registrations/edit'
    end
  end
end
