class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    if current_user.sign_in_count == 1
      unless session[:already_welcomed]
        flash.now[:success] = 'Welcome to PickUpMyKid!'
        session[:already_welcomed] = true
      end
    end
  end

  def update
    respond_to do |format|
      if current_user.update_attributes(params[:user])
        format.html { redirect_to user_path(current_user), notice: 'Successfully updated.' }
        format.json { render json: current_user }
      else
        format.html { render 'devise/custom/registrations/edit' }
        format.json { render json: current_user }
      end
    end
  end

  def setup_paypal
    current_user.update_attributes(paypal_email: params[:user][:paypal_email])
    @ridership = Ridership.find(params[:user][:ridership_id])
    render 'rides/responded'
  end
end
