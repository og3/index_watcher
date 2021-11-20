namespace :sp500_data do
  task get: :environment do
    require_relative "../browser_operation.rb"

    browser_operation = BrowserOperation.new
    browser_operation.starting_headless_chrome
    browser_operation.get_to(Sp500::URL)

    params = {}
    Sp500.data_location_hash.each do |key, xpath|
      data = browser_operation.find_data(xpath).text
      params[key] = if key == :date
                       data.to_date
                     elsif key == :point
                       data.delete(",").to_f
                     else
                       data.to_f
                     end
    end

    browser_operation.quit_driver
    begin Sp500.new(params).save! rescue exit end
  end

  task notice: :environment do
    require_relative "../line_messaging_api.rb"

    sp500 = Sp500.last

    exit if sp500.noticed?
    exit unless sp500.rsi_under_30? || sp500.rsi_upper_70?

    message = sp500.rsi_under_30? ? sp500.notice_message("30を下回ったようです") : sp500.notice_message("70を上回ったようです")

    LineMessagingApi.broadcast(message)
    sp500.after_notice
  end
end
