class BrowserOperation
  require 'selenium-webdriver'

  def get_to(url)
    @driver.get(url)
  end

  def starting_headless_chrome
    if Rails.env.production?
      Selenium::WebDriver::Chrome.path = ENV.fetch('GOOGLE_CHROME_BIN', nil)
      options = Selenium::WebDriver::Chrome::Options.new(
        prefs: { 'profile.default_content_setting_values.notifications': 2 },
        binary: ENV.fetch('GOOGLE_CHROME_SHIM', nil)
      )
    else
      options = Selenium::WebDriver::Chrome::Options.new
    end
    # heroku上でのメモリ不足対策
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--remote-debugging-port=9222')
    @driver = Selenium::WebDriver.for :chrome, options: options
  end

  def quit_driver
    @driver.quit
  end

  def find_data(xpath)
    @driver.find_element(:xpath, xpath)
  end

end
