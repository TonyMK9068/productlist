class MessagesController < ApplicationController

  def create
    @user = current_user
    @list = List.find(params[:message][:list_id])
    @recipient = params[:message][:recipient]

    @message = @user.messages.new(recipient: params[:message][:recipient])
    authorize! :create, List, message: "Not authorized"

    if @message.save
      ShareMailer.notify(@user, @list, @recipient).deliver
      flash[:notice] = "Message sent"
      
      redirect_to list_path(@list)
    else
      flash[:error] = "Message failed to send. Check email address"
      render list_path(@list)
    end
  end
end
