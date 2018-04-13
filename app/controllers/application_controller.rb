class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

	include SessionsHelper

  helper_method :current_user #tell rails we wish to use this in our helpers and views
	
  #checks to see if the user_id exists within the session
#  def current_user
#    @current_user ||= Google_User.find(session[:user_id]) if session[:user_id]
#  end

end
