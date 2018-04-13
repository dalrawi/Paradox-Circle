class SessionsController < ApplicationController

	def new
	end
  
	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			log_in user
			redirect_to user
		else
			flash.now[:danger] = 'Invalid email/password combination' #preliminary error message
			render 'new'
		end
#Commented this out to test login, not ready for push
 #   user = Google_User.from_omniauth(request.env["omniauth.auth"])
#    session[:user_id] = user.id
#    redirect_to '/home/show'
  end

  def destroy
    #session[:user_id] = nil
		log_out
    redirect_to root_path
  end
end
