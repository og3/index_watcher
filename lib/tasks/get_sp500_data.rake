require_relative "../browser_operation.rb"

namespace :get_sp500_data do
  task get: :environment do
    sp500 = Sp500.new

    browser_operation = BrowserOperation.new
    browser_operation.starting_headless_chrome
    browser_operation.get_to(Sp500::URL)

    sp500.date = browser_operation.find_data(Sp500::DATE_LOCATION).text.to_date
    sp500.point = browser_operation.find_data(Sp500::POINT_LOCATION).text.delete(",").to_f
    sp500.day_before_ratio = browser_operation.find_data(Sp500::RATIO_LOCATION).text.to_f
    sp500.day_before_ratio_percent = browser_operation.find_data(Sp500::PERCENT_LOCATION).text.to_f
    sp500.rsi = browser_operation.find_data(Sp500::RSI_LOCATION).text.to_f
    browser_operation.quit_driver
    begin sp500.save! rescue exit end
  end
end
