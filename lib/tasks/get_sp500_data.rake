require_relative "../browser_operation.rb"

namespace :get_sp500_data do
  task get: :environment do
    sp500 = Sp500.new

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
    sp500.update_or_exit(params)
  end
end
