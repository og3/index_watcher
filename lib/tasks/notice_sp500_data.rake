require_relative "../line_messaging_api.rb"

namespace :notice_sp500_data do
  task notice: :environment do
    sp500 = Sp500.last

    exit if sp500.noticed?
    exit unless sp500.rsi_under_30? || sp500.rsi_upper_70?

    message = sp500.rsi_under_30? ? sp500.notice_message("30を下回ったようです") : sp500.notice_message("70を上回ったようです")

    LineMessagingApi.broadcast(message)
    sp500.after_notice
  end
end
