# http://stackoverflow.com/questions/5832631/devise-redirect-after-login-fail
#
class CustomFailure < Devise::FailureApp
  def redirect_url
    root_path
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end
