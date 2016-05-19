class UserNotifier < ApplicationMailer
   
  def welcome(user, user_email)
    @user = user
    mail(to: user_email, subject: "Welcome to Thrive Lending, #{@user.first_name}!")
  end

  def unwelcome(user, user_email)
    @user = user
    mail(to: user_email, subject: "Farewell from Thrive Lending, #{@user.first_name}!")
  end

  def contract_notice(lender, borrower, user_email)
    @lender = lender
    @borrower = borrower
    mail(to: user_email, subject: "Contract between #{lender.first_name} #{lender.last_name} & #{borrower.first_name} #{borrower.last_name}")
  end

  def forgot_password(user)
    @user = user
    mail(to: user.email, subject: "Reset your Thrive Lending password, #{@user.first_name}")
  end

end
