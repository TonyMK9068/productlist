class ShareListMailer < ActionMailer::Base
  default from: '9324kmdfimjfl234@gmail.com'

  def share_list(sender, list, recipient)
    @user, @list, @recipient = sender, list, recipient

    mail(to: @recipient,
      subject: "#{@user.display_user_as("username")} has shared a wish list with you!")
  end
end