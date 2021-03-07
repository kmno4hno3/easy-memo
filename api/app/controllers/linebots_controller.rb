# class LinebotsController < ApplicationController
class LinebotsController < ActionController::Base
  require 'line/bot'
  require 'json'
  require 'net/http'
  require 'uri'

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
          case event.message['text']
          when "Qiita"
            p "qiita"

            access_token = ENV.fetch("QIITA_ACCESS_TOKEN")
            get_items_uri = 'https://qiita.com/api/v2/items'
            query = 'created:>=2018-04-01'
            page = 1
            per_page = 100

            uri = URI.parse(get_items_uri)
            uri.query = URI.encode_www_form({ query: query, per_page: per_page, page: page })
            req = Net::HTTP::Get.new(uri.request_uri)
            req['Authorization'] = "Bearer #{access_token}"

            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = true
            res = http.request(req)

            p "~~~"
            p JSON.parse(res.body)
            p "~~~"           

            
          else
            message = {}

            File.open(Rails.root + 'app/services/line_bot/messages/json/text.json') do |file|
              hash = JSON.load(file)
              hash['text'] = event.message['text'].length
              message = hash
            end

            client.reply_message(event['replyToken'], message)
          end
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
