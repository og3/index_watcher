class Sp500 < ApplicationRecord
  URL = "https://nikkeiyosoku.com/spx/rsi/"
  DATE_LOCATION = "/html/body/div[3]/div/div[1]/div[5]/div[1]/table/tbody/tr[1]/td[1]"
  POINT_LOCATION = "/html/body/div[3]/div/div[1]/div[5]/div[1]/table/tbody/tr[1]/td[2]"
  RATIO_LOCATION = "/html/body/div[3]/div/div[1]/div[5]/div[1]/table/tbody/tr[1]/td[3]/span"
  PERCENT_LOCATION = "/html/body/div[3]/div/div[1]/div[5]/div[1]/table/tbody/tr[1]/td[4]/span"
  RSI_LOCATION = "/html/body/div[3]/div/div[1]/div[5]/div[1]/table/tbody/tr[1]/td[5]"

  def rsi_under_30?
    rsi <= 30
  end

  def notice_rsi_under_30
    "s&p500のrsiが30を下回ったようです。
    日付：#{date}
    ポイント：#{point}
    rsi：#{rsi}"
  end

  def rsi_upper_70?
    rsi >= 70
  end

  def notice_rsi_upper_30
    "s&p500のrsiが70を上回ったようです。
    日付：#{date}
    ポイント：#{point}
    rsi：#{rsi}"
  end

end
