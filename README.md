# Thrive Lending
## Built with Ruby on Rails

### Authors
[Mark Miranda](http://github.com/notmarkmiranda), [Kami Boers](https://github.com/kamiboers), [Thom Pickett](https://github.com/thompickett)

This project was created as a part of the curriculum for the [Turing School of Software & Design](http://turing.io).

### Overview

This Rails application took a previous project that had a single store and pivoted it to have a platform that has many users, who can each have many loan requests or offers. These then can be turned into a contract by another user.

### Live Version

You can find a live version of this application on Heroku at: [https://thrive-lending.herokuapp.com/](https://thrive-lending.herokuapp.com/)

### Setup

To set up a local copy of this project, perform the following:

  1. Clone the repository: `git clone https://github.com/kristindiannefoss/little_shop.git`
  2. `cd` into the project's directory
  3. Run `bundle install`
  4. Run `rake db:create db:migrate db:seed` to set up the postgres database and seed it with users, loan_offers, loan_requests, and contracts.
    - If you would like to create your own database information do not run `db:seed`
    - If you do seed, it you will be provided with an admin with a username: josh and password: password
    - If you do seed, it you will be provided with a regular user with a username: josh and password: password
  5. Run the application in the dev environment by running `rails s`

### App Features

Some of the main features of the app include:

#### Users
  Users can:
  - create loan requests
  - create loan offers
  - edit loan requests
  - edit loan offers
  - delete their own loan request
  - delete their own loan offers
  - view other users loan requests
  - view other users loan offers
  - turn other users loans into contracts through a submission form

#### Admins

  Admin can:
  - do everything a user can
  - delete any user
  - delete any users loan offers
  - delete any users loan requests
  - delete any users contracts

### Dependencies

This application depends on many ruby gems, all of which are found in the `Gemfile` and can be installed by running `bundle install` from the terminal in the main directory of the project.
