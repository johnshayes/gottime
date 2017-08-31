class RemoveMeetingIdFromMessages < ActiveRecord::Migration[5.1]
  def change
    remove_reference :messages, :meeting, index: true, foreign_key: true
    add_reference :chat_rooms, :meeting, index: true, foreign_key: true
  end
end
