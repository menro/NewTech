## Welcome to Newtech

Newtech is a web-application visible at http://demo.algonauti.com/newtech


## Getting Started

At the command prompt (from Rails.root project), create .env and database.yml configuration files and setup preferences:

    $ cp .env-example .env
    $ cp config/database.yml-example config/database.yml

Setup gem dependencies:

    $ bundle install

Run system:bootstrap rake task:

    $ rake db:drop
    $ rake db:create
    $ rake system:bootstrap
    $ rake system:import_crunchbase_companies

Run rails server:

    $ rails s

Go to http://localhost:3000/


