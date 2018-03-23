class SessionsController < ApplicationController

	def new
	end
  
	def create
    user = Google_User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to '/home/show'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
