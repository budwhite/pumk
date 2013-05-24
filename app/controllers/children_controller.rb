class ChildrenController < ApplicationController
  def destroy
    child = Child.find(params[:id])
    child.destroy
    redirect_to :back
  end
end
