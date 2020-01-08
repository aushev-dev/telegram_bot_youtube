require 'telegram/bot'

token = '907693429:AAGwtga9dT_2AIj2Km8RrT4OffypCLeZPGI'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
  	when /youtu/
  		%x(youtube-dl -x --audio-format mp3 --output "audio.%(ext)s" #{message.text})
		bot.api.send_audio(chat_id: 64819429, audio: Faraday::UploadIO.new('/Users/mairbekaushev/rails/telegram-bot2/audio.mp3', 'audio/mp3'))
	when //
		bot.api.send_message(chat_id: 64819429, text: message.text)
    end
  end
end