class ApplicationController < ActionController::Base
	include SessionsHelper
	protect_from_forgery
	protected

	def current_user
  		@current_user ||= User.find_by(id: session[:user_id])
  	end
  	
  	helper_method :current_user, :signed_in?

  	def current_user=(user)
    	@current_user = user
    	log_out
    	session[:user_id] = user.id
  	end
  	
  	private
  	
  	#Confirms a logged in user
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
       end
     end
end
