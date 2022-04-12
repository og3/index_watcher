namespace :sp500_data do
  task get: :environment do
    require_relative '../browser_operation'

    browser_operation = BrowserOperation.new
    browser_operation.starting_headless_chrome
    browser_operation.get_to(Sp500::URL)

    params = {}
    Sp500.data_location_hash.each do |key, xpath|
      sleep(5)
      data = browser_operation.find_data(xpath).text
      params[key] = if key == :date
                      data.to_date
                    elsif key == :point
                      data.delete(',').to_f
                    else
                      data.to_f
                    end
    end

    browser_operation.quit_driver
    begin
      Sp500.new(params).save!
    rescue StandardError
      exit
    end
  end

  task notice: :environment do
    require_relative '../line_messaging_api'

    latest_sp500 = Sp500.last

    exit if latest_sp500.noticed?

    message = ''
    message << "S&P500のポイントが直近3日間の合計で#{Sp500::TARGET_POINT_RANGE_ABS}ポイント変動したようです。\n\n" if latest_sp500.reached_target_point_range?
    message << "S&P500のrsiが30を下回ったようです。\n\n" if latest_sp500.rsi_under_30?
    message << "S&P500のrsiが70を上回ったようです。\n\n" if latest_sp500.rsi_upper_70?

    if message.present?
      message << latest_sp500.sp500_condition_message
    else
      exit
    end

    LineMessagingApi.broadcast(message)
    latest_sp500.update_noticed_flag
  end
end
