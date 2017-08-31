class AddChatroomToMessages < ActiveRecord::Migration[5.1]
  def change
    add_reference :messages, :chat_room, foreign_key: true
  end
end
