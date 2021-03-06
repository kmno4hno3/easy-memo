# class LinebotsController < ApplicationController
class LinebotsController < ActionController::Base
  require 'line/bot'
  # require './app/services/line_bot/messages/test'
  require 'json'

  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery :except => [:callback]

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
  end

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end

    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          msg = event.message['text']
          length = msg.length

          # p TestMessage.send

          # message = {
          #   type: "text",
          #   text: length
          # }

          message = {
            type: "location",
            title: "my location",
            address: "〒160-0022 東京都新宿区新宿４丁目１−６", 
            latitude: 35.688806,
            longitude: 139.701739  
        }
        message = {}

        File.open(Rails.root + 'app/services/line_bot/messages/json/imagemap.json') do |file|
          hash = JSON.load(file)
          message =  hash
        end

          client.reply_message(event['replyToken'], message)
        when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
          response = client.get_message_content(event.message['id'])
          tf = Tempfile.open("content")
          tf.write(response.body)
        end
      end
    end
    "OK"
  end

end
