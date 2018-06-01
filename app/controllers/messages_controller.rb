class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    chat = Chat.includes(:recipient).find(params[:chat_id])
    message = chat.messages.create(message_params)
    locals = { message: message, user: current_user }
    message_partial = render_to_string 'messages/_message', layout: false, locals: locals
    render json: { message_partial: message_partial }, status: :ok
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :body)
  end
end
