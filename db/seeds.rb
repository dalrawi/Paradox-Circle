# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
artists_list = ["Marathon Of Disappointed","Astute Rodent","Twinkie Dichotomy","Chronic Parallax","Sunlit Shroom","Platinum Spatula","Bio Dab","Assessment Puppy"]
tags_list = ["techno","electronic","soundcloud rapper","FL studio","electrofunk","classical","indie","post apocalyptic glam metal"]
artists_list.each do |band|
	Artist.create(name: band)
end
tags_list.each do |genre|
	Tag.create(name: genre)
end
