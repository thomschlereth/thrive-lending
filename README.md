# NachomomsPaleo
## Built with Ruby on Rails

### Authors
[Mark Miranda](http://github.com/notmarkmiranda), [Kris Foss](https://github.com/kristindiannefoss), [Deb Hamel](https://github.com/deborahleehamel)

This project was created as a part of the curriculum for the [Turing School of Software & Design](http://turing.io).

### Overview

This Rails application is a store for specialty food items(paleo-friendly dinosaur products). A user can create an account and purchase available items. An admin can create items and manage retired status for items.

### Live Version

You can find a live version of this application on Heroku at: [https://nachomomspaleo.herokuapp.com/](https://nachomomspaleo.herokuapp.com/)

### Setup

To set up a local copy of this project, perform the following:

  1. Clone the repository: `git clone https://github.com/kristindiannefoss/little_shop.git`
  2. `cd` into the project's directory
  3. Run `bundle install`
  4. Run `rake db:create db:migrate db:seed` to set up the postgres database and seed it with users, items, and categories.
    - If you would like to create your own users, artist, items, and categories do not run `db:seed`
    - The seed file does not include any setup for admins, so those must be created manually by running `rails c` and adding a user to the database with role = 2
  5. Run the application in the dev environment by running `rails s`

### App Features

Some of the main features of the app include:

#### Users

Users can browse the items by category. Each item has a name, description, image, and price associated with it. Users can add any items that are not retired to their cart. Users do not need to be signed in to browse items or add them to their cart. However, upon checkout, if a user is not signed in they will be asked to create an account or login before being allowed to check out. A user cannot add any items, but can choose to change their account to an "artist" account at any point. However, once they are signed up as an artist, they cannot change back to a default user. Users can also view any of their past orders and the order status.

#### Admins

Admins can create and edit items. This includes managing each item's retired status. 

#### Other Features

The app implements Paperclip and uses Amazon Web Services S3 to store and host any image uploads.

### Test Suite

The test suite tests the application on multiple levels. To run all of the tests, run `rake test` from the terminal in the main directory of the project. The feature tests (integration tests) rely mainly on the [capybara gem](https://github.com/jnicklas/capybara) for navigating the various application views.

The project also utilizes leverages a bootstrap theme called 'bikeshop'.

### Dependencies

This application depends on many ruby gems, all of which are found in the `Gemfile` and can be installed by running `bundle install` from the terminal in the main directory of the project.
