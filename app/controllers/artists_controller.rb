class ArtistsController < ApplicationController
	def index
		@search_term = params[:query]
		@artists = Artist.search(@search_term,"artists")
		@artisttags = Artist.search(@search_term,"tags")
	end
	def show
		@artist = Artist.find(params[:id])
		@tag = @artist.tags.build
	end
	#update method for updating tags
  	def artist_params
		params.require(:tag).permit(:name)
	end

end
