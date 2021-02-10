module RoomsHelper
  def most_new_message_preview(room)
    message = room.messages.order(updated_at: :desc).limit(1)
    message = message[0]
    if message.present?
      tag.p "#{message.body}", class: "dm_list_content_link_box_message"
    else
      tag.p "[ まだメッセージはありません ]", class: "dm_list_content_link_box_message"
    end
  end

  def opponent_user(room)
    entry = room.entries.where.not(user_id: current_user)
    @user = entry[0].user
    return @user
  end
end
