class SessionsController < ApplicationController
	include SessionsHelper

	def new
	end
  
	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			log_in user
			redirect_back_or user
		else
			flash.now[:danger] = 'Invalid email/password combination'
			render 'new'
		end
	end
	def create_googlefb
		user = User.from_omniauth(request.env["omniauth.auth"])
		log_in user
		redirect_back_or user
	end

  def destroy
    session.clear
    redirect_to root_path, notice: "Logged out!"
  end
end

