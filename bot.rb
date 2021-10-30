require 'telegram/bot'

token = ENV['TOKEN']
user_list = ENV['WL'].split(',')

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
		begin
			if user_list.include?(message.chat.id.to_s)
				case message.text
				when /youtu/
					%x(/app/youtube-dl.dms -x --audio-format mp3 --output "/tmp/audio.%(ext)s" #{message.text})
					bot.api.send_audio(chat_id: message.chat.id, audio: Faraday::UploadIO.new('/tmp/audio.mp3', 'audio/mp3'))
          %x(rm /tmp/audio.mp3)
        when /tiktok/
          file = %x(tiktok-scraper video #{message.text} -d -w --filepath /tmp)
          file_name = file.split('/').last.strip
          file_path = "/tmp/#{file_name}"
          if File.exist?(file_path)
						bot.api.send_video(chat_id: message.chat.id, video: Faraday::UploadIO.new(file_path, 'video/mp4'))
          else
						bot.api.send_message(chat_id: message.chat.id, text: "Nothing to send and error #{file}")
					end
				when //
					bot.api.send_message(chat_id: message.chat.id, text: message.text)
				end
			end
		rescue StandardError => e
			bot.api.send_message(chat_id: message.chat.id, text: "#{e.inspect}")
		end
	end
end
