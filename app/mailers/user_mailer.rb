class UserMailer < ActionMailer::Base
  default from: "Welcome@giftshare.com"

  def signup_confirmation(user)
    @user = user
    mail( to: @user.email, subject: "Thank you for signing up at GiftShare.com!")
  end
end
