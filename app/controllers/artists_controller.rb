class ArtistsController < ApplicationController
	def index
		@search_term = params[:query]
		@artists = Artist.search(@search_term)
	end
end
