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
        # メッセージの場合
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {}

          File.open(Rails.root + 'app/services/line_bot/messages/json/text.json') do |file|
            hash = JSON.load(file)
            hash['text'] = event.message['text'].length
            message = hash
          end

          client.reply_message(event['replyToken'], message)
        else
          message = {
            type: "text",
            text: "対応していないメッセージです"
          }
          client.reply_message(event['replyToken'], message)
        end
      when Line::Bot::Event::Postback
        # ポストバックの場合
        p "postback"
        message = {
          type: "text",
          text: "postback"
        }
        client.reply_message(event['replyToken'], message)
      end
    end
  end
end
