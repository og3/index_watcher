require 'line/bot'
require 'net/http'
require 'uri'
require 'json'

namespace :notice_sp500_data do
  task notice: :environment do
    sp500 = Sp500.last

    exit if sp500.noticed?
    exit unless sp500.rsi_under_30? || sp500.rsi_upper_70?

    message = if sp500.rsi_under_30?
                sp500.notice_rsi_under_30
              elsif sp500.rsi_upper_70?
                sp500.notice_rsi_upper_30
              end
    # post先のurl
    uri = URI.parse('https://api.line.me/v2/bot/message/broadcast')
    http = Net::HTTP.new(uri.host,uri.port)
    http.use_ssl = true

    # Header
    headers = {
        'Authorization'=>"Bearer #{ENV["LINE_CHANNEL_TOKEN"]}",
        'Content-Type' =>'application/json',
        'Accept'=>'application/json'
    }
    # Body
    params = {"messages" => [{"type" => "text", "text" => message}]}

    response = http.post(uri.path, params.to_json, headers)
    sp500.noticed = true
    sp500.save!
  end
end
