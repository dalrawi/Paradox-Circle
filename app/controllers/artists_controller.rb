class ArtistsController < ApplicationController
	def index
		@search_term = params[:query]
		@artists = Artist.search(@search_term,"artists")
		@artisttags = Artist.search(@search_term,"tags")
	end
	def show
		@artist = Artist.find(params[:id])
		@tag = Tag.new
	end
	#update method needed for adding tags
	def update
	    @artist = Artist.find(params[:id])
	    @artist.tags << @tag
  	end
  	def permitted_params
  		params.require(:artist).permit(:tags)
	end
end
