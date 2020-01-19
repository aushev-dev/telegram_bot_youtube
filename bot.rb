require 'telegram/bot'

token = '907693429:AAGwtga9dT_2AIj2Km8RrT4OffypCLeZPGI'



Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|

    begin
    	unless message.chat.id == 64819429 
    			bot.api.send_message(chat_id: message.chat.id, text: "Извини, #{message.from.first_name}, у тебя нет доступа")
    			break
    	end
		    case message.text
			  	when /youtu/
			  		%x(/app/youtube-dl.dms -x --audio-format mp3 --output "/tmp/audio.%(ext)s" #{message.text})
					bot.api.send_audio(chat_id: message.chat.id, audio: Faraday::UploadIO.new('/tmp/audio.mp3', 'audio/mp3'))
				when //
					bot.api.send_message(chat_id: message.chat.id, text: message.text)
		    end 	
	 rescue
	 	bot.api.send_message(chat_id: message.chat.id, text: "Error")
	 end
  end
end


