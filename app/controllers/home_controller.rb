class HomeController < ApplicationController
  layout 'lp'

  def index
    if params.has_key? :cherrycrest
      @cc = true
    end
    @user = User.new
  end

  def help
  end

  def about
  end
  
  private

  def determine_layout
    if params.has_key? :cherrycrest
      'application'
    else
      'lp'
    end
  end
end
