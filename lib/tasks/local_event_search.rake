require 'nokogiri'
require 'open-uri'

namespace :local_event_search do
	
	@linkString = ''
	@links = Array.new

  task google_search: :environment do
		url = "http://www.google.com/search?q=live+local+music+near+me"
		#open page to be parsed
		doc = Nokogiri::HTML(open(url))
		
		#scrape first page google results for any h3.r and a class tags
		doc.css('h3.r a').each do |link|
		
			#scrape href link value
			#This works becuase link is a nokogiri XML Node
			@linkString = link['href'].split('=')[1].strip
			#strips off anything extra that google added to the links
			@linkString = @linkString.split('&')[0].strip

			#push sanitzed link string onto an array
			@links.push(@linkString) 
		end #end do loop for doc.css
	
		#search for an remove any strings that may not be in url format
		@links.each do |element|
			if !element.include? 'http' #if the current element does not include 'http'
				@links.delete(element)
			end #end if
		end #end do loop
 
  end #end google_search task


	
end #end namespace
