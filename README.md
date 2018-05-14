# Paradox Circle Music Discovery App
Ruby Version: 2.4.3  
Rails Version: Latest (using git in gem file)  
PostgreSQL: (latest)

## How to run:
0. Install the above (Ruby, Rails, PostgreSQL).
1. Download the repository, have a command prompt open and cd to the downloaded project repository.
2. Run 'bundle install' to download the gem dependencies for the application that are listed in the Gemfile for the project.
3. Having created a Postgres database using the PostgreSQL application and configured the config/database.yml file in the application to match your db credentials, in the command prompt run 'rails db:migrate' to use the associated migration files to generate the database schema. May need to do 'rails db:create' or whatever the command prompt states is needed to do. 
4. a .env file needs to be created in the root directory that will hold your API keys for Google/Facebook authentication. The project will run without this part but none of the third party authentication will work without it.
5. Finally, running 'rails start' or 'rails s' starts the server, Loading up a broswer to http://localhost:3000 should take you to the home page of the application. 

## Structure

This project follows the typical structure of a MVC web application. Models are our classes, the main ones are the User class, the artist class, Event class, Tag class, and Venue class.
The views contain all the HTML templates in which we use embedded ruby to dynamically generate the content from the template.
The controller files contain methods to handle actions the user may make through the corresponding views. The model files contain the logic associated with that class and the association type with the other classes.
The database used is PostgreSQL, though Active Record is used in the application to interact with the database.

