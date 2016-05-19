require 'rails_helper'

RSpec.describe UserNotifier do

  it "welcomes a user" do
    create_user
    user = User.last
    email = UserNotifier.welcome(user, user.email).deliver_now
 
    refute ActionMailer::Base.deliveries.empty?
    expect(email.from).to eq ["no-reply@thrive-lending.herokuapp.com"]
    expect(email.to).to eq [user.email]
    expect(email.subject).to eq "Welcome to Thrive Lending, #{user.first_name.capitalize}!"
  end  

  it "unwelcomes a user" do
    create_user
    user = User.last
    email = UserNotifier.unwelcome(user, user.email).deliver_now
 
    refute ActionMailer::Base.deliveries.empty?
    expect(email.from).to eq ["no-reply@thrive-lending.herokuapp.com"]
    expect(email.to).to eq [user.email]
    expect(email.subject).to eq "Farewell from Thrive Lending, #{user.first_name}!"
  end

  it "notifies both users of a contract" do
    create_user(2)
    user1 = User.first
    user2 = User.last
    email = UserNotifier.contract_notice(user1, user2, user1.email).deliver_now
 
    refute ActionMailer::Base.deliveries.empty?
    expect(email.from).to eq ["no-reply@thrive-lending.herokuapp.com"]
    expect(email.to).to eq [user1.email]
    expect(email.subject).to eq "Contract between #{user1.first_name} #{user1.last_name} & #{user2.first_name} #{user2.last_name}"
  end

  it "emails a link to forgotten password" do
    create_user
    user = User.last
    user.password_reset_token = "i2jlk213h23h21i3"
    email = UserNotifier.forgot_password(user).deliver_now
 
    refute ActionMailer::Base.deliveries.empty?
    expect(email.from).to eq ["no-reply@thrive-lending.herokuapp.com"]
    expect(email.to).to eq [user.email]
    expect(email.subject).to eq "Reset your Thrive Lending password, #{user.first_name}"
  end

end

