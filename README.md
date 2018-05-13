# Paradox Circle Music Discovery App
Ruby Version: 2.4.3  
Rails Version: Latest (using git in gem file)  
PostgreSQL: (latest)

## How to run:

1. Download the repository, have a command prompt open and cd to the downloaded project repository.
2. Run 'bundle install' to get the gem dependencies for the application.
3. Having created a Postgres database using the PostgreSQL application and configured the generated database.yml file in the application to match your db credentials, in the command prompt run 'rails db:migrate' to use the associated migration files to generate the database schema. May need to do 'rails db:create' or whatever the command prompt states is needed to do. 
4. a .env file needs to be created in the root directory that will hold your API keys for Google/Facebook authentication. The project will run without this part but none of the third party authentication will work without it.
5. Finally, running 'rails start' or 'rails s' starts the server, pointing a broswer to http://localhost:3000 should take you to the home page of the application. 

