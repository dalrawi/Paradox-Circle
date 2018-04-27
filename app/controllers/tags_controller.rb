class TagsController < ApplicationController
	def create
		@tag = Tag.create(tag_params)
		@tag.save!

	def tag_params
		params.require(:tag).permit(:name)
	end

	def new
		@tag = Tag.new(:name)
	end

end
