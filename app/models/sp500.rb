class Sp500 < ApplicationRecord
  URL = 'https://nikkeiyosoku.com/spx/rsi/'.freeze
  DATE_LOCATION = '/html/body/div[3]/div/div[1]/div[6]/div[1]/table/tbody/tr[1]/td[1]'.freeze
  POINT_LOCATION = '/html/body/div[3]/div/div[1]/div[6]/div[1]/table/tbody/tr[1]/td[2]'.freeze
  RATIO_LOCATION = '/html/body/div[3]/div/div[1]/div[6]/div[1]/table/tbody/tr[1]/td[3]/span'.freeze
  PERCENT_LOCATION = '/html/body/div[3]/div/div[1]/div[6]/div[1]/table/tbody/tr[1]/td[4]/span'.freeze
  RSI_LOCATION = '/html/body/div[3]/div/div[1]/div[6]/div[1]/table/tbody/tr[1]/td[5]'.freeze
  TARGET_POINT_RANGE_ABS = 100.0
  PERIOD_DAYS = 3

  def self.data_location_hash
    { date: Sp500::DATE_LOCATION,
      point: Sp500::POINT_LOCATION,
      day_before_ratio: Sp500::RATIO_LOCATION,
      day_before_ratio_percent: Sp500::PERCENT_LOCATION,
      rsi: Sp500::RSI_LOCATION }
  end

  # TODO: マジックナンバーは無くしたい
  def rsi_under_30?
    rsi <= 30
  end

  def rsi_upper_70?
    rsi >= 70
  end

  def reached_target_point_range?
    point_range_abs = Sp500.last(PERIOD_DAYS).pluck(:day_before_ratio).sum.abs
    point_range_abs >= TARGET_POINT_RANGE_ABS
  end

  def sp500_condition_message
    "\n日付：#{date}
    ポイント：#{point}
    rsi：#{rsi}

    * データの出典：https://nikkeiyosoku.com/spx/rsi/"
  end

  def update_noticed_flag
    update!(noticed: true)
  end
end
