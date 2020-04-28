
module GetCompanies
  extend self
  def get_from_yahoo_api
    client_id = 'dj00aiZpPU0wOFFTVTlweDZ0ciZzPWNvbnN1bWVyc2VjcmV0Jng9NmQ-'
    num = 100
    yahoo_manage = YahooApiManage.last
    if yahoo_manage.blank?
      start_id = 1
    else
      start_id = yahoo_manage.next_start_id
    end

    params = URI.encode_www_form({ appid: client_id , results: num , start: start_id})
    url = URI.parse("https://job.yahooapis.jp/v1/furusato/company/?#{params}")
    req = Net::HTTP::Get.new(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    res = http.request(req)
    res_hash = JSON.parse(res.body)

    count = res_hash["count"]
    p count
    next_start_id = start_id + count
    p next_start_id

    companies = res_hash["results"]

    companies.each do|hash|
      corporate_num = hash["corporationId"]
      name = hash["name"]
      prefecture_name = hash["prefecture"].blank? ? "_":hash["prefecture"]
      city_name = hash["city"].blank? ? "_":hash["city"]
      town = hash["town"].blank? ? "_":hash["town"]
      block = hash["block"].blank? ? "_":hash["block"]
      building = hash["building"].blank? ? "_":hash["building"]
      address  = prefecture_name + city_name + town + block + building
      president_name = hash["presidentName"]
      phone_number = hash["tel"]
      capital = hash["capital"]
      employees = hash["employees"]
      established_date = hash["establishmentDate"].blank? ? nil:hash["establishmentDate"].to_date
      listed = hash[:listed]
      facebook_url = hash["facebookUrl"]
      twitter_url = hash["twitterUrl"]
      web_url = hash["webUrl"]

      YahooSource.create!(corporate_num: corporate_num,
                          name: name,
                          address: address,
                          phone_number: phone_number,
                          prefecture_name: prefecture_name,
                          city_name: city_name,
                          president_name: president_name,
                          capital: capital,
                          employees: employees,
                          established_date: established_date,
                          listed: listed,
                          facebook_url: facebook_url,
                          twitter_url: twitter_url,
                          web_url: web_url)

    end
    YahooApiManage.create(next_start_id: next_start_id)
  end
end

