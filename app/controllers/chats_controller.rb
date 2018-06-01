class ChatsController < ApplicationController
  before_action :authenticate_user!

  def create
    chat = Chat.get(current_user.id, params[:user_id])
    chat_partial = render_to_string 'chats/_chat', layout: false, locals: { chat: chat, user: current_user }
    render json: { chat_partial: chat_partial }, status: :ok
  end
end
