module InputData
  extend self

  require "csv"

  def test
    sources = ["company_hokkaido", "company_aomori", "company_iwate", "company_miyagi", "company_akita", "company_yamagata",
               "company_fukushima", "company_ibaraki", "company_tochigi", "company_gunma", "company_saitama", "company_chiba", "company_tokyo",
               "company_kanagawa", "company_niigata", "company_toyama", "company_ishikawa", "company_fukui", "company_yamanashi", "company_nagano",
               "company_gifu", "company_shizuoka", "company_aichi", "company_mie", "company_shiga", "company_kyoto", "company_osaka", "company_hyogo",
               "company_nara", "company_wakayama", "company_tottori", "company_shimane", "company_okayama", "company_hiroshima", "company_yamaguchi",
               "company_tokushima", "company_kagawa", "company_ehime", "company_kouchi", "company_fukuoka", "company_saga", "company_nagasaki",
               "company_kumamoto", "company_oita", "company_miyazaki", "company_kagoshima", "company_okinawa"]
    b = 0
    sources.each do |source|
      companies_csv = CSV.readlines("db/csv/#{source}.csv")
      companies_csv.shift
      a = companies_csv.first
      p a[6]
      b += 1
    end
    p b
  end

  def input_prefecture
    prefectures = ["北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県", "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都",
                   "神奈川県", "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県", "静岡県", "愛知県", "三重県", "滋賀県", "京都府", "大阪府", "兵庫県",
                   "奈良県", "和歌山県", "島根県", "鳥取県", "岡山県", "広島県", "山口県", "徳島県", "香川県", "愛媛県", "高知県", "福岡県", "佐賀県", "長崎県", "熊本県",
                   "大分県", "宮崎県", "鹿児島県", "沖縄県"]

    if prefectures.count == 47
      prefectures.each do |prefecture|
        Prefecture.create!(name: prefecture)
      end
    else
      p '登録する県の数が間違っています'
    end
  end

  def input_city

  end

  def input_company_from_csv
    sources = ["company_hokkaido", "company_aomori", "company_iwate", "company_miyagi", "company_akita", "company_yamagata",
               "company_fukusshima", "company_ibaraki", "company_tochigi", "company_gunnma", "company_saitama", "company_chiba", "company_tokyo",
               "company_kanagawa", "company_niigata", "company_toyama", "company_ishikawa", "company_fukui", "company_yamanashi", "company_nagano",
               "company_gifu", "company_shizuoka", "company_aichi", "company_mie", "company_shiga", "company_kyoto", "company_osaka", "company_hyogo",
               "company_nara", "company_wakayama", "company_tottori", "company_shimane", "company_okayama", "company_hiroshima", "company_yamaguchi",
               "company_tokushima", "company_kagawa", "company_ehime", "company_kouchi", "company_fukuoka", "company_saga", "company_nagasaki",
               "company_kumamoto", "company_oita", "company_miyazaki", "company_kagoshima", "company_okinawa"]

    sources.each do |source|
      companies_csv = CSV.readlines("db/csv/#{source}.csv")
      companies_csv.shift
      companies_csv.each do |row|
        company = Company.find_by(corporate_num: row[1])
        if company.blank?
          date = row[5].to_date
          company = Company.create!(name: row[6],
                                    corporate_num: row[1],
                                    established_date: date,
                                    source_id: 2)
          prefecture_id = Prefecture.where('name like ?', "%#{row[9]}%").pluck(:id).first
          city_id = City.find_by(name: row[10]).present? ? City.find_by(name: row[10]).id : nil
          if city_id.blank?
            city = City.create(name: row[10])
            city_id = city.id
          end
          prefecture = row[9].present? ? row[9] : "_"
          city = row[10].present? ? row[10] : "_"
          other_address = row[11].present? ? row[11] : "_"
          address = prefecture + city + other_address

          company.company_addresses.create!(address: address,
                                            prefecture_id: prefecture_id,
                                            city_id: city_id,
                                            source_id: 2)
        else
          company_address = company.address
          if company_address.present?
            if company_address.prefecture_id.blank?
              prefecture_id = Prefecture.where('name like ?', "%#{row[9]}%").pluck(:id).first
              city_id = City.find_by(name: row[10]).present? ? City.find_by(name: row[10]).id : nil
              if city_id.blank?
                city = City.create(name: row[10])
                city_id = city.id
              end
              prefecture = row[9].present? ? row[9] : "_"
              city = row[10].present? ? row[10] : "_"
              other_address = row[11].present? ? row[11] : "_"
              address = prefecture + city + other_address

              company.company_addresses.create!(address: address,
                                                prefecture_id: prefecture_id,
                                                city_id: city_id,
                                                source_id: 2)

              company_address.update!(is_invalid: 1)
            end
          else
            prefecture_id = Prefecture.where('name like ?', "%#{row[9]}%").pluck(:id).first
            city_id = City.find_by(name: row[10]).present? ? City.find_by(name: row[10]).id : nil
            if city_id.blank?
              city = City.create(name: row[10])
              city_id = city.id
            end
            prefecture = row[9].present? ? row[9] : "_"
            city = row[10].present? ? row[10] : "_"
            other_address = row[11].present? ? row[11] : "_"
            address = prefecture + city + other_address

            company.company_addresses.create!(address: address,
                                              prefecture_id: prefecture_id,
                                              city_id: city_id,
                                              source_id: 2)
          end
        end
      end
      p source
    end
  end
end


