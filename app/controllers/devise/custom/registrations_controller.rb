class Devise::Custom::RegistrationsController < Devise::RegistrationsController
  def edit
    current_user.addresses.build if current_user.addresses.blank?
    current_user.children.build if current_user.children.blank?
    render :edit
  end

  # overwriting Devise gem in order to customize redirect path after signup failure
  def create
    build_resource

    if resource.save
      if resource.active_for_authentication?     
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_in_path_for(resource)
      else
        set_flash_message :notice, :inactive_signed_up, :reason => resource.inactive_message.to_s if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords(resource)
      # Solution for displaying Devise errors on the homepage found on:
      # http://stackoverflow.com/questions/4101641/rails-devise-handling-devise-error-messages
      flash[:notice] = flash[:notice].to_a.concat resource.errors.full_messages
      session[:signup_fail] = ''
      redirect_to root_path
    end
  end

  def new
  end
end 
