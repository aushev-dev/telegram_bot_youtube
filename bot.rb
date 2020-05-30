require 'telegram/bot'

token = ENV[TOKEN]



Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
		begin
			if message.chat.id == 64819429 ||  message.chat.id == 608598294
				case message.text
				when /youtu/
					%x(/app/youtube-dl.dms -x --audio-format mp3 --audio-quality 8 --output "/tmp/audio.%(ext)s" #{message.text})
					bot.api.send_audio(chat_id: message.chat.id, audio: Faraday::UploadIO.new('/tmp/audio.mp3', 'audio/mp3'))
				when //
					bot.api.send_message(chat_id: message.chat.id, text: message.text)
				end 	
			end
		rescue
			bot.api.send_message(chat_id: message.chat.id, text: "Error")
		end
	end
end