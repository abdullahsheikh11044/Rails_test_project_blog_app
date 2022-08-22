Prerequisites

The setups steps expect following tools installed on the system.
    Github
    Ruby 2.7.0
    Rails 5.2.8

    1. Check out the repository
    
    git clone git@github.com//abdullahsheikh11044/Rails_test_project_blog_app
    
    2. Create database.yml file
    
    Copy the sample database.yml file and edit the database 
    
    configuration as required.cp config/database.yml.sample 
    
    config/database.yml3. 
    3. Create and setup the database
    
    Run the following commands to create and setup the database.
    
    rails db:create
    rails db:migrate
    
    4. Start the Rails serverYou can start the rails server using the command given below.
 
    rails s
    
    And now you can visit the site with the URL http://localhost:3000