class ShareMailer < ActionMailer::Base
  default from: 'contact.me@anthonyjcorreia.com'

  def notify(sender, list, recipient)
    @user = sender
    @list = list
    @recipient = recipient

    mail(to: @recipient, subject: "#{@user.display_user_as("username")} has shared a wish list with you!")
  end
end