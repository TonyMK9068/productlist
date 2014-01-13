class SystemMailer < ActionMailer::Base
  default from: 'notifications@giftshare.io'

  def sign_up_notification
    mail( to: 'contact.me@anthonyjcorreia.com', subject: "A new user just signed up")
  end
end
