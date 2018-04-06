require 'nokogiri'
require 'open-uri'

namespace :local_event_search do
  desc "TODO"
  task auto_create: :environment do
		url = "http://www.google.com/search?q=live+local+music+nar+me"
		#open page to be parsed
		doc = Nokogiri::HTML(open(url))
		
		#TODO parse page
		# scrape relevant links
		#add them to the event table in the DB
	
  end

end
