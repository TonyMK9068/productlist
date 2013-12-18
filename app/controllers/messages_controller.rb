class MessagesController < ApplicationController

  def create
    @user = current_user
    @list = List.find(params[:message][:list_id])
    @recipient = params[:recipient]

    @message = @user.messages.new(recipient: params[:message][:recipient])

    authorize! :manage, @list, message: "You can only share your own lists"
    if @message.save
      ShareListMailer.share_list(@user, @list, @recipient).deliever
      flash[:notice] = "Message sent"
      
      redirect_to list_path(@list)
    else
      flash[:error] = "Message failed to send. Check email address"
      render list_path(@list)
    end
  end
end
