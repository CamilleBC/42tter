# frozen_string_literal: true

module MessagesHelper
  def return_message(message_id)
    Message.find_by_id(message_id)
  end

  def return_date(message)
    date = message.created_at
    date_string = message.created_at.strftime('%H:%M')
    unless date.day == DateTime.now.day && date.month == DateTime.now.month && date.year == DateTime.now.year
      date_string += message.created_at.strftime(' on %d/%m/%y')
    end
    date_string
  end
end
