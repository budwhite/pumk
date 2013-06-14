class UsersController < ApplicationController
  before_filter :authenticate_user!, except: :create

  def create
    User.create!(
      first_name: params[:user][:first_name],
      last_name: params[:user][:last_name],
      email: params[:user][:email],
      phone_number: params[:user][:phone_number],
      comment: params[:user][:comment],
      password: Devise.friendly_token[0,20]
    )
    flash[:success] = 'Thanks for signing up! We will get in touch with you promptly!'
    redirect_to root_path
  end

  def show
    if current_user.id == params[:id].to_i
      if current_user.sign_in_count == 1
        unless session[:already_welcomed]
          flash.now[:success] = 'Welcome to PickUpMyKid!'
          session[:already_welcomed] = true
        end
      end
    else
      @user = User.find(params[:id])
      render :show_other
    end
  end

  def show_other
  end

  def update
    if params[:pk].nil?
      new_record = true
    else
      new_record = false
    end

    case params[:model]
    when 'address'
      if new_record
        address = current_user.addresses.build(
          name: params[:name],
          street1: params[:street1],
          city: params[:city],
          state: params[:state],
          zipcode: params[:zipcode]
        )
        if address.save
          render json: address
        else
          render json: address.errors, status: :unprocessable_entity
        end
      else
        address = Address.find(params[:pk])
        if address.update_attributes(params[:name].to_sym => params[:value])
          head :ok
        else
          render json: address.errors, status: :unprocessable_entity
        end
      end
    when 'child'
      if new_record
        child = current_user.children.build(
          name: params[:name],
          gender: params[:gender],
          grade: params[:grade],
          teacher: params[:teacher]
        )
        if child.save
          render json: child
        else
          render json: child.errors, status: :unprocessable_entity
        end
      else
        child = Child.find(params[:pk])
        if child.update_attributes(params[:name].to_sym => params[:value])
          head :ok
        else
          render json: child.errors, status: :unprocessable_entity
        end
      end
    when 'user'
      if current_user.update_attributes(params[:name].to_sym => params[:value])
        head :ok
      else
        render json: current_user.errors, status: :unprocessable_entity
      end
    end

    #respond_to do |format|
      #if current_user.update_attributes(params[:user])
        #format.html { redirect_to user_path(current_user), notice: 'Successfully updated.' }
        #format.json { render json: current_user }
      #else
        #format.html { render 'devise/custom/registrations/edit' }
        #format.json { render json: current_user }
      #end
    #end
  end

  def setup_paypal
    current_user.update_attributes(paypal_email: params[:user][:paypal_email])
    @ridership = Ridership.find(params[:user][:ridership_id])
    render 'rides/responded'
  end
end
