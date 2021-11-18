class LineMessagingApi
  require 'line/bot'
  require 'net/http'
  require 'uri'
  require 'json'

  def self.broadcast(message)
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
  end
end
