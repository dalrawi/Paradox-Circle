# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :output, "log/local_scrape_log.log"

#every 24 hours scrape google
#and subsequently scrape every website
#that has local music listings

#scrapes for shows in abq for now this is a placeholder
#city can be updated based on user_city which will be part of the
#the users profile
every 24.hours do
	rake "local_event_search:google_search['albquerque']"
end
