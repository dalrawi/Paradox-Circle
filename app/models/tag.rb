class Tag < ApplicationRecord
	has_and_belongs_to_many :artists

	validates :name, presence: true, length: { maximum: 20 }
end
