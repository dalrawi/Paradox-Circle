#responsible for creating a new Tag record

class TagsController < ApplicationController
	def create
		@tag = Tag.new(tag_params)
		@tag.save!
		#logger.debug "params: #{params.inspect}"
		artist = Artist.find_by(id: params[:tag][:artistId])
		artist.tags << @tag
		artist.save!
		redirect_to artist
	end

	def tag_params
		params.require(:tag).permit(:name)
	end

	def new
		@tag = Tag.new(:name)
	end

end
