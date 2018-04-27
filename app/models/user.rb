class User < ApplicationRecord
	has_and_belongs_to_many :events
	has_secure_password
	has_many :quotes, dependent: :destroy
	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
		    user.provider = auth.provider
		    user.uid = auth.uid
		    user.name = auth.info.name unless user.name != nil
		    user.email =  SecureRandom.hex + '@example.com' unless user.email != nil
		    user.password_digest = SecureRandom.urlsafe_base64 unless user.password_digest != nil
		    user.save!
		end
	end
	
	#Defines a proto-feed
	def feed
	  Quote.where("user_id = ?", id)
	end
end
