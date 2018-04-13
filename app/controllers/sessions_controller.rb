class SessionsController < ApplicationController

	def new
	end
  
	def create
		##if no email submittied use google or fb login, the Google_User model is not the correct naming convenition
		##but it works for all omniauth users
		if params[:email].blank?
			user = Google_User.from_omniauth(request.env["omniauth.auth"])
			session[:user_id] = user.id
			redirect_to '/show'
		else
			user = User.find_by(email: params[:session][:email].downcase)
			if user && user.authenticate(params[:session][:password])
				log_in user
				redirect_to user
			else
				flash.now[:danger] = 'Invalid email/password combination' #preliminary error message
				render 'new'
			end
		end
#Commented this out to test login, not ready for push
 #   user = Google_User.from_omniauth(request.env["omniauth.auth"])
#    session[:user_id] = user.id
#    redirect_to '/home/show'
  end

  def destroy
    session[:user_id] = nil
		log_out
    redirect_to root_path
  end
end

