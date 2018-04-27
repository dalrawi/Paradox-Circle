class StaticPagesController < ApplicationController
  def home
    @quote = current_user.quotes.build if logged_in?
  end

  def help
  end

  def about
  end
end
