class PagesController < ApplicationController

  def splash
    @featured_users = User.all.sample(9)
  end
end
