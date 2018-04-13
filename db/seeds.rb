# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#reset tables before seed
Artist.delete_all
Tag.delete_all

artists_list = ["Astute Rodent","Jazzy Dichotomy","Chronic Parallax","Sunlit Shroom","Platinum Spatula","Bio Dab","Assessment Puppy","Papa Roach", "Linkin Park", "Nickelback"]
tags_list = ["techno","electronic","soundcloud rapper","FL studio","electrofunk","classical","indie","post apocalyptic glam metal","Sad music","Jazz"]
images = ["wretched.png","a_perfect_circle.png","beatles.png"]
tags_list.each do |genre|
	Tag.create(name: genre)
end
artists_list.each do |band|
	Artist.create(name: band, image_url: images.sample)
	#Assign a randomly selected tag to each artist
	Artist.find_by(name: band).tags << Tag.find_by(name: tags_list.sample)
end
