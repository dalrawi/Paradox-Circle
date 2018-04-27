class QuotesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  def create
    @quote = current_user.quotes.build(quote_params)
    if @quote.save
      flash[:success] = "Quote saved!"
      redirect_to current_user
    else
      render 'home/show'
    end
  end
  
  def destroy
  end
  
  def quote_params
    params.require(:quote).permit(:content)
  end
end
