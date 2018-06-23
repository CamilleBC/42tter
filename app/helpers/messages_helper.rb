module MessagesHelper
	def return_message(message_id)
		Message.find_by_id(message_id)
	end
end
