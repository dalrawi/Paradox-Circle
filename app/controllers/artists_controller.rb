class ArtistsController < ApplicationController
	def index
		@search_term = params[:query]
		@artists = Artist.search(@search_term,"artists")
		@artisttags = Artist.search(@search_term,"tags")
	end
end
