class Devise::Custom::RegistrationsController < Devise::RegistrationsController
  def edit
    current_user.addresses.build if current_user.addresses.blank?
    current_user.children.build if current_user.children.blank?
    render :edit
  end
end 
