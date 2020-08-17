require 'selenium-webdriver'
require 'uri'

class Instagram::InstagramService < BaseService
  attr_accessor :driver

  def initialize(username, password)
    # Selenium::WebDriver::Chrome.driver_path = "/mnt/c/chromedriver.exe"
    # ua = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36'
    # caps = Selenium::WebDriver::Remote::Capabilities.chrome('chromeOptions' => {args: ["--user-agent=#{ua}", 'window-size=1280x800', '--incognito']}) # シークレットモード
    # client = Selenium::WebDriver::Remote::Http::Default.new
    # client.read_timeout = 300
    # @driver = Selenium::WebDriver.for :chrome, desired_capabilities: caps, http_client: client
    # @driver.manage.timeouts.implicit_wait = 30


    # @wait_time = 120
    # @timeout = 120
    # Selenium::WebDriver.logger.output = File.join("./", "selenium.log")
    # Selenium::WebDriver.logger.level = :warn
    # @driver = Selenium::WebDriver.for :chrome
    # @driver.manage.timeouts.implicit_wait = @timeout
    # wait = Selenium::WebDriver::Wait.new(timeout: @wait_time)
    # @driver.navigate.to 'https://www.instagram.com/accounts/login/?source=auth_switcher'
    # @driver.find_element(:name, 'username').send_keys(username)
    # @driver.find_element(:name, 'password').send_keys(password)
    # sleep 1
    # @driver.find_element(:name, 'password').send_keys(:return)
    # Selenium::WebDriver::Chrome.driver_path = "/mnt/c/chromedriver.exe"
    ua = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36'
    caps = Selenium::WebDriver::Remote::Capabilities.chrome('chromeOptions' => { args: ["--user-agent=#{ua}", 'window-size=1280x800', '--incognito'] }) # シークレットモード
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = 300
    @driver = Selenium::WebDriver.for :chrome, desired_capabilities: caps, http_client: client
    @driver.manage.timeouts.implicit_wait = 30
    @driver.navigate.to'https://www.instagram.com/accounts/login/?source=auth_switcher'
    @driver.find_element(:name, 'username').send_keys(username)
    @driver.find_element(:name, 'password').send_keys(password)
    sleep 1
    @driver.find_element(:name, 'password').send_keys(:return)
  end

  def good_hashtag(key_word, number)
    encode_word = URI.encode(key_word)
    sleep 3
    @driver.navigate.to "https://www.instagram.com/explore/tags/#{encode_word}/"
    sleep 2
    @driver.execute_script("document.querySelectorAll('article img')[9].click()")
    sleep 2
    number.times {
      begin
        @driver.execute_script("document.querySelector('body > div._2dDPU.CkGkG > div.zZYga > div > article > div.eo2As > section.ltpMr.Slqrh > span.fr66n > button > div > span ').click()")
      rescue
        puts "already good this post"
      end
      sleep 2
      @driver.execute_script("document.querySelector('a.coreSpriteRightPaginationArrow').click()")
      sleep 2
    }
  end

  def good_user_post(username, number)
    sleep 3
    @driver.navigate.to "https://www.instagram.com/#{username}/"
    sleep 2
    @driver.execute_script("document.querySelectorAll('article img')[0].click()")
    sleep 2
    number.times {
      begin
        @driver.execute_script("document.querySelector('body > div._2dDPU.CkGkG > div.zZYga > div > article > div.eo2As > section.ltpMr.Slqrh > span.fr66n > button > div > span ').click()")
      rescue
        puts "already good this post"
      end
      sleep 2
      @driver.execute_script("document.querySelector('a.coreSpriteRightPaginationArrow').click()")
      sleep 2
    }
  end

  def good_and_follow(key_word, number, follower_count)
    encode_word = URI.encode(key_word)
    account_lists = []
    sleep 3
    @driver.navigate.to "https://www.instagram.com/explore/tags/#{encode_word}/"
    sleep 2
    @driver.execute_script("document.querySelectorAll('article img')[9].click()")
    sleep 2
    number.times {
      begin
        @driver.execute_script("document.querySelector('body > div._2dDPU.CkGkG > div.zZYga > div > article > div.eo2As > section.ltpMr.Slqrh > span.fr66n > button > div > span ').click()")
        e = @driver.find_element(:css, 'body > div._2dDPU.CkGkG > div.zZYga > div > article > header > div.o-MQd.z8cbW > div.PQo_0.RqtMr > div.e1e1d > span > a')
        account = e.text if e.present?
        account_lists << account if account.present?
      rescue
        puts "already good this post"
      end
      sleep 2
      @driver.execute_script("document.querySelector('a.coreSpriteRightPaginationArrow').click()")
      sleep 2
    }
    if account_lists.present?
      account_lists.each do |account|
        begin
          @driver.navigate.to "https://www.instagram.com/#{account}/"
          e_f = @driver.find_element(:css, '#react-root > section > main > div > ul > li:nth-child(2) > a > span')
          follower = e_f.text.to_i if e_f.present?
          if follower <= follower_count
            @driver.execute_script("document.querySelector('#react-root > section > main > div > header > section > div.Y2E37 > div > div > span > span.vBF20._1OSdk > button').click()")
          end
        rescue
          next
        end
      end
    end
  end
end
