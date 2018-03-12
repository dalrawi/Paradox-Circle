class Artist < ApplicationRecord
	has_and_belongs_to_many :places
	has_and_belongs_to_many :tags
	
	def self.search(keyword)
		Artist.where("name ilike ?", "%#{keyword}%")
	end
end
