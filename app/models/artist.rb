class Artist < ApplicationRecord
	has_and_belongs_to_many :places
	has_and_belongs_to_many :tags

	
	def self.search(keyword,searchType)
		if searchType == "artists"
			Artist.where("name ilike ?", "%#{keyword}%")
		elsif searchType == "tags"
			Artist.joins(:tags).where("tags.name ilike ?","%#{keyword}%")
		end
	end
	
	#no longer used
	def tag_list
		#return the tags applied to this artist
    	tags.map(&:name).join(', ')
    end

  	def update_tags(newtag)
  		Artist.tags << newtag
  	end
end
