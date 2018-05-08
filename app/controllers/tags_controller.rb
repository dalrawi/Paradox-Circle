#responsible for creating a new Tag record and appropriate association to artist

class TagsController < ApplicationController
	def create
		@tag = Tag.new(tag_params)
		@tag.save!
		#logger.debug "params: #{params.inspect}"
		#artist id only available to tags controller after submit is clicked.
		artist = Artist.find_by(id: params[:tag][:artistId])
		artist.tags << @tag
		artist.save!
		redirect_to artist
		flash[:success]="Tag added"
	end

	def increaseTagCount
		#need to update count in Artists_Tags table
		# UPDATE Artists_Tags
		# SET count = count + 1
		# WHERE artist_id=artistId AND tag_id=@tag.id
		flash[:success]="Tag added"
		redirect_to 'home#show'
	end

	def tag_params
		params.require(:tag).permit(:name)
	end

	def new
		@tag = Tag.new(:name)
	end


end
