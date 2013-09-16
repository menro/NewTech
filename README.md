=======
New Tech
====
Travis Status: [![Build Status](https://travis-ci.org/menro/NewTech.png)](https://travis-ci.org/menro/NewTech)

Waffle.io Progress: [![Stories in Ready](https://badge.waffle.io/menro/newtech.png?label=ready)](https://waffle.io/menro/newtech)  

Developed for new tech colorado. (http://bdnt.org)

The app provides two visualizations over a map for companies within a state. Maximum zoom out summarizes all companies by county and displays them as a hotspot. Zooming into a hot spot displays a list of companies and their actual location on a map. Either zoom level can be filtered in real time to adjust the total number of companies displayed. Filters include: company found date, category of business, company provided tags, hiring, investment to date and employee count

Future:
Ability to register for new tech events (integration with Meetup.com). Syncing company data with the startup genome project

Comments, contributors and forkers all welcome


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

Run rails server:

    $ rails s

Go to http://localhost:3000/

