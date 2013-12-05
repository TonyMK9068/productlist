# class FavoriteMailer < ActionMailer::Base
#   default from: GiftShare@noreply.com

#   def share_list(sender, list, recipient)
#     @user = sender
#     @list = list
#     @recipient = recipient
    
#     mail(to: @recipient,
#       subject: "#{(@user.username || @user.email)} has shared a wish list with you!")
#   end
# end
