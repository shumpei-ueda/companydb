gem "activerecord-import"

def parse_capital(capital)
  capital
    .gsub(/[(（].*?[)）]|,/, "")
    .gsub(/百/, "00")
    .scan(/\d*[千万億兆]/)
    .inject(0) {|result, c|
      d = c[/\d+/].to_i
      case c[-1]
      when "万" then
        result += d * 10_000
      when "億" then
        result += d * 100_000_000
      when "兆" then
        result += d * 1_000_000_000_000
      end
    }
end

module ReflectCompanies extend self
  def reflect_from_yahoo
    yahoo_id = 1
    yahoo_data = YahooSource.all
        # where(is_reflected: nil)
    count = yahoo_data.count
    p count
    if yahoo_data.present?
      yahoo_data.each do |data|
        corporate_num = data.corporate_num
        name = data.name
        prefecture_name =data.prefecture_name
        city_name =data.city_name
        address  = data.address
        president_name = data.president_name
        phone_number = data.phone_number
        capital =data.capital
        employees = data.employees
        established_date = data.established_date
        listed = data.listed
        facebook_url = data.facebook_url
        twitter_url = data.twitter_url
        web_url = data.web_url
        is_reflected = data.is_reflected

        company = Company.find_by(corporate_num: corporate_num)
        if company.blank?
          company = Company.create!(corporate_num: corporate_num,
                                    name: name,
                                    established_date: established_date,
                                    source_id: yahoo_id)

          #住所作成
          prefecture_id = Prefecture.where('name like ?', "%#{prefecture_name}%").pluck(:id).first
          city_id = City.where('name like ?', "%#{city_name}%").pluck(:id).first
          if address.present?
          company.company_addresses.create!(address: address,
                                            prefecture_id: prefecture_id,
                                            city_id: city_id,
                                            source_id: yahoo_id)
          end


          #会社電話番号作成
          if phone_number.present?
          company.company_phone_numbers.create!(phone_number: phone_number,
                                                source_id: yahoo_id)
          end


          #会社WebURL作成
          if web_url.present?
          company.company_web_urls.create!(url: web_url,
                                           source_id: yahoo_id)
          end


          #会社代表作成
          if president_name.present?
          company.company_presidents.create!(president_name: president_name,
                                             source_id: yahoo_id)
          end


          #上場情報作成
          if listed.present?
          company.company_listings.create!(listed: listed,
                                           source_id: yahoo_id)
          end

          #Facebook作成
          if facebook_url.present?
          company.company_facebooks.create!(url: facebook_url,
                                            source_id: yahoo_id)
          end


          #Twitter作成
          if twitter_url.present?
          company.company_twitters.create!(url: twitter_url,
                                           source_id: yahoo_id)
          end

        else
          company_address = company.address
          company_phone_number = company.phone_number
          company_web_url = company.web_url
          company_president = company.president
          company_listing = company.listing
          company_facebook = company.facebook
          company_twitter = company.twitter

          #住所作成
          prefecture_id = Prefecture.where('name like ?', "%#{prefecture_name}%").pluck(:id).first
          city_id = City.where('name like ?', "%#{city_name}%").pluck(:id).first


          if address.present?
            if company_address.present?
              if prefecture_id != company_address.prefecture_id
                company.company_addresses.create!(address: address,
                                                  prefecture_id: prefecture_id,
                                                  city_id: city_id,
                                                  source_id: yahoo_id)
                company_address.update!(is_invalid: 1)
              elsif city_id != company_address.city_id
                company.company_addresses.create!(address: address,
                                                  prefecture_id: prefecture_id,
                                                  city_id: city_id,
                                                  source_id: yahoo_id)
                company_address.update!(is_invalid: 1)
              end
            else
            company.company_addresses.create!(address: address,
                                              prefecture_id: prefecture_id,
                                              city_id: city_id,
                                              source_id: yahoo_id)
            end


          end


          #会社電話番号作成
          if phone_number.present?
            if company_phone_number.present?
              unless  phone_number == company_phone_number.phone_number
                company.company_phone_numbers.create!(phone_number: phone_number,
                                                      source_id: yahoo_id)
                company_phone_number.update!(is_invalid: 1)
              end
            else
              company.company_phone_numbers.create!(phone_number: phone_number,
                                                  source_id: yahoo_id)
              end
          end


          #会社WebURL作成
          if web_url.present?
            if company_web_url
              unless web_url == company_web_url.url
                company.company_web_urls.create!(url: web_url,
                                                 source_id: yahoo_id)
              end
            else
              company.company_web_urls.create!(url: web_url,
                                             source_id: yahoo_id)
            end
          end


          #会社代表作成
          if president_name.present?
            if company_president.present?
              unless president_name == company_president.president_name
                company.company_presidents.create!(president_name: president_name,
                                                   source_id: yahoo_id)
                company_president.update!(is_invalid: 1)
              end
            end
            else
            company.company_presidents.create!(president_name: president_name,
                                               source_id: yahoo_id)
          end


          #上場情報作成
          if listed.present?
            if company_listing.present?
              unless  listed == company_listing.listed
                company.company_listings.create!(listed: listed,
                                                 source_id: yahoo_id)
                company_listing.update!(is_invalid: 1)
              end

            else
              company.company_listings.create!(listed: listed,
                                             source_id: yahoo_id)
            end

          end

          #Facebook作成
          if facebook_url.present?
            if company_facebook.present?
              unless facebook_url == company_facebook.url
                company.company_facebooks.create!(url: facebook_url,
                                                  source_id: yahoo_id)
              end
            else
              company.company_facebooks.create!(url: facebook_url,
                                                source_id: yahoo_id)
            end
          end


          #Twitter作成
          if twitter_url.present?
            if company_twitter.present?
              unless  twitter_url == company_twitter.url
                company.company_twitters.create!(url: twitter_url,
                                                 source_id: yahoo_id)
              end
            else
              company.company_twitters.create!(url: twitter_url,
                                             source_id: yahoo_id)
            end
          end

        end
        data.update!(is_reflected: 1)
      end

    end

  end

  def reflect_from_mynavi_tenshoku
    mynavi_media_id = 2
    company_media_ad_queue = []
    company_capital_queue = []
    company_web_url_queue = []
    # MynaviTenshoku.where(is_reflected: false)

    MynaviTenshoku.all.find_each do |record|
      candidates = Company.where(name: record.name).to_a
      next if candidates.size != 1 #照合が大変なのでまず社名がユニークなら入れることに

      # president_name はパースが面倒
      # employees は格納先テーブルがない

      company = candidates.first

      company_media_ad_queue << CompanyMediaAd.new(
        company_id: record.id,
        media_id: mynavi_media_id
      )

      company_capital_queue << CompanyCapital.new(
        company_id: record.id,
        capital: parse_capital(record.capital)
      )

      company_web_url_queue << CompanyWebUrl.new(
        company_id: record.id,
        web_url: record.web_url
      )

    end

    CompanyMediaAd.import company_media_ad_queue
    CompanyCapital.import company_capital_queue
    CompanyWebUrl.import company_web_url_queue

  end
    
end