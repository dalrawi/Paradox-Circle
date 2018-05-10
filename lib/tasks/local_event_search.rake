require 'nokogiri'
require 'open-uri'

namespace :local_event_search do
	
	@linkString = ''
	@links = Array.new
	@docs = Array.new
	@event_times = Array.new
	@event_dates = Array.new
	@venues = Array.new
	@bands = Array.new
	@event_date = ''

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

		##create documents out of all the links
		@links.each do |link|
			#don't search yelp pages always 503
			if !link.include? 'yelp'
				@docs.push(Nokogiri::HTML(open(link)))
			end #end if			
		end #end do


		##call proceeding task
		#debug puts
		puts 'Finsihed calling google_search' 
		Rake::Task['local_event_search:event_scrape'].invoke
		puts 'Finished calling event_scrape'
		Rake::Task['local_event_search:venue_update'].invoke
		puts 'Finished calling venue_update'
 
  end #end google_search task

	##### Note #####
	#this task is a lot longer than it should be
	#need to be able to split bands and tags at a later time
	################

	task :event_scrape => :environment do
		#local vars		
		shit_to_parse = ''
		temp_date = ''
		
		
		to_be_parsed = ''

		shit_to_ignore = ['classical', 'sludge', 'blues', 'folk', 'rock', 'alternative',
		'goth', 'industrial', 'Latin', 'jazz', 'soul', 'trivia', 'country', 'Americana',
		'funk', 'rap' '80\'s', 'hiphop', 'singersongwriter', 'disco', 'variety', 'bluegrass',
		'Spanish', 'New Mexican', 'tropical', 'pop', 'classic', 'mellow', 'alt.', 'alt', 'open-mic',
		'singer-songwriter', 'acoustic', 'open mic', 'indie', 'experimental', 'punk', 'dream', 'death metal',
		'heavy metal', 'thrash']
	
		##Super convoluted loops to try an only pull music 
		##events from the webpage because I am retarded and 
		##so is trying to parse CSS in any generalized fashion
		@docs[0].css('.location, .category').each do |venue|
			next if venue.content.include? 'Music'		
			break if venue.content.include? 'Arts'
			@venues.push(venue.content)
		end #end loop

		@docs[0].css('.value, .category').each do |time|
			next if time.content.include? 'Music'
			break if time.content.include? 'Arts'
			@event_times.push(time.content)
		end #end loop
		
		##causes an error if the band includes the word music
		##or arts in the bands name seriously this is ridiculous
		@docs[0].css('.summary, .category').each do |band|
			next if band.content.include? 'Music'
			break if band.content.include? 'Arts'
			##parse out the worthless genre shit
			##seriously such a pita		
			shit_to_parse = band.content
			#cut out any non alphabetical/numerical values ie the fucking dot seperators
			shit_to_parse.gsub!(/[^0-9A-Za-z ]/, '')
			
			#now loop through the genres and remove them from the strings and add
			#only bands to the array

			shit_to_ignore.each do |ignore|
				if shit_to_parse.include? ignore
					trash = shit_to_parse.slice! ignore
				end #end if
			end #end inner loop
			
			@bands.push(shit_to_parse.strip)

		end #end loop
		
		
		@docs[0].css('.eventdates').each do |date|
			break if date.content.include? 'Notices'
			@event_date = date.content
		end #end loop
		
		#for debugging purposes
		puts @event_date
		puts @venues.inspect
		
		##OMG there are multiple bands per element with 
		##NO LOGICAL WAY to differentiate them making
		##adding bands individually to an event is FUCKING RETARDED JUST LIKE ME
		puts @bands.inspect #for debugging purposes
		#puts events.inspect

		##DATE Creation
		##creates the date formatted string
		##and then pushes them onto an array
		@event_times.each do |new_event|
			temp_date = @event_date + ' ' + new_event
			temp_date.to_datetime
			@event_dates.push(temp_date)
		end #end loop

		puts @event_dates.inspect
		##Create new records and save them in the events table
		@venues.each do |e|
			#ensure the event doesn't already exist
			if !Event.where(venue: e, event_date: @event_dates.at(@venues.index(e)).to_datetime).exists?			
				@created_at = Time.now
				new_event = Event.new(created_at: @created_at, updated_at: @created_at, event_date: @event_dates.at(@venues.index(e)), 
					bands: @bands.at(@venues.index(e)), venue: e)
				new_event.save
			end #end if 
		end #end loop

		#loop through bands and add them to the artists table

		parsed = Array.new
		@bands.each do |parse|
			##do some stuff and split bands in here
			if parse.include? '  '
				parse.split('  ').each do |band|
					if band.count("A-Za-z0-9") > 1
						parsed.push(band)
					end #end if
				end #end inner loop
			end #end if
		end #end loop
		
		
		#loop through parsed band
		parsed.each do |band|
			#if the artist name already exists in the db do not add the band again
		  if !Artist.exists?(['name LIKE ?', band])
				@created_at = Time.now
				#does not scrape for image url atm
				new_artist = Artist.new(name: band, created_at: @created_at, updated_at: @created_at, image_url: 'tbd.png')
				new_artist.save
			end #end if
		end #end loop

		Artist.all.each do |artist|
			if artist.image_url.include? 'tbd'
				artist.image_url = 'tbd.png'
				artist.save
			end #end if
		end #end loop
	end #end task
	

	#### VENUE_UPDATE ####
	######################

	task :venue_update => [:environment] do 
		
		#local vars for stoof
		search_string = ''
		@Addresses = Array.new
	
		@venues.each do |place|

			place.gsub!(/[^0-9A-Za-z ]/, '')
			place.encode('UTF-8', :invalid => :replace, :undef => :replace)

			puts place
			#okay maybe we scrape yelp because I can't seem to get the css class to populate the addr??
			#google is super paranoid about scraping apparently
			search_string = "https://www.yellowpages.com/search?search_terms=" + place + "&geo_location_terms=Albuquerque%2C+NM1" 
			#puts search_string
			venue_search = Nokogiri::HTML(open(search_string))
			
	
			#quick and dirty addition to places table
			if !Place.exists?(['name LIKE ?', place])			
				new_venue = Place.new(name: place, created_at: Time.now, updated_at: Time.now, address: venue_search.css('.street-address, .locality')[0].content)
				new_venue.save
				#@Addresses.push(venue_search.css('.street-address, .locaility')[0].content)				
			end #end if
		end #end loop

		#puts @Addresses.inspect 
	end #end venue_update
	
end #end namespace
