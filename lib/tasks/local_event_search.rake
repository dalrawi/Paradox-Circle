require 'nokogiri'
require 'open-uri'

namespace :local_event_search do
	
	@linkString = ''
	@links = Array.new

  task :google_search, [:city] => [:environment] do |t, args|
		
		url = "http://www.google.com/search?q=live+local+music+" + args.city
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
	
		puts @links.inspect
		##call proceeding task 
		Rake::Task['local_event_search:event_scrape'].invoke
 
  end #end google_search task

	task :event_scrape => :environment do
		
		venues = Array.new
		event_time = Array.new
		event_date = Array.new

		to_be_parsed = ''

		shit_to_ignore = ['classical', 'sludge', 'blues', 'folk', 'rock', 'alternative',
		'goth', 'industrial', 'Latin', 'jazz', 'soul', 'trivia', 'country', 'Americana',
		'funk', 'rap' '80\'s', 'hiphop', 'singersongwriter', 'disco', 'variety', 'bluegrass',
		'Spanish', 'New Mexican', 'tropical', 'pop', 'classic']
	
		#make sure @links has elements
		if @links.length > 0
			puts '@links is not empty'
			#loop through each link and scrape events?? 
			#this may not be the cleanest way to do this as each website will have
			#different layouts and formats

			@links.each do |link|
			
				#open current link as a Nokogiri HTML doc		
				doc = Nokogiri::HTML(open(link))
				
				doc.css('header.eventdates').each do |date|
					event_date.push(date.content)
				end #end loop

				puts event_date[0]
	

				#loop through locations and add them to the venues array.
				#TODO need to check if .location is nil and loop for a different node if possible 
				doc.css('.location').each do |venue_name|
					venues.push(venue_name.content)
					puts venue_name.content
				end #end doc loop

				doc.css('time abbr.value').each do |e_time|
					event_time.push(e_time.content)
					puts e_time.content
				end #end loop
			
				#sanitize event times
				event_time.each do |e_time|
					if e_time.length < 1
						event_time.delete(e_time)
					end # end if		
				end #end loop
	
				puts event_time.inspect
	
				doc.css('.summary').each do |shit_value|
					to_be_parsed = shit_value.content
	
					to_be_parsed.gsub!(/[^0-9A-Za-z ]/, '')
	
					shit_to_ignore.each do |ignore|
						if to_be_parsed.include? ignore
							trash = to_be_parsed.slice! ignore
						end #end if
					end #end inner loop
	
					puts to_be_parsed
				end #end loop
				break #break after first pass in loop failsafe atm
				
			end #end do loop		
		
		end #end if
		
	end #end task
	
end #end namespace
