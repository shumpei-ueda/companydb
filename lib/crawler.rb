gem "activerecord-import"

require "uri"
require "open-uri"
require "nokogiri"
require "mechanize"

module Crawler
  extend self

  def crawling_rikunabi
    # 対象のURL
    @search_url = "https://job.rikunabi.com/2021/company/r544600011/"
    # Nokogiriで切り分け
    doc = Nokogiri::HTML(open(@search_url))

    c = []
    doc.search("td.ts-h-mod-dataTable02-cell").each do |a|
      c << a.content
      p a.content
    end
    p c[5]

    doc.search('//*[@id="company-data04"]/div/text()').each do |a|
      p a.content
    end

  end

  def crawling_mynavi_tenshoku(_region: "hokkaido", _is_only: false, _page: 1)
    regions = ["hokkaido", "tohoku", "kitakanto", "shutoken", "koshinetsu", "hokuriku", "tokai", "kansai", "chugoku", "shikoku", "kyushu", "global"]
    if !regions.include?(_region) then
      raise "regionは#{regions.join(", ")}の中から指定してください."
    end

    if !["true", "false", false].include?(_is_only) then
      raise "各地域のみ募集のページから始めるかを、true,falseで指定してください."
    end
    _is_only = _is_only == "true"

    begin
      _page = Integer(_page)
    rescue => e
      raise "pageは数値で指定してください."
    end
    if _page < 1 then
      raise "pageは1以上で指定してください"
    end

    base_url = "https://tenshoku.mynavi.jp"
    regions[regions.index(_region)..].each do |region|
      for is_only in [false, true] do
        if _is_only then
          _is_only = false
          next
        end

        page = 1
        if _page > 1 then
          page = _page
          _page = 1
        end
        while true do
          companies = []
          sleep 1
          begin
            company_links = "#{base_url}/#{region}/list/#{ is_only ? "only/" : ""}#{ page > 1 ? "pg#{page}" : "" }"
            p "reading #{company_links}"
            res = open(company_links, {redirect: false})
          rescue => e
            if e.message == "301 301"
              p "finish reading #{base_url}/#{region}/list/#{ is_only ? "only/" : ""}"
            else
              p e
            end

            break
          end

          doc = Nokogiri::HTML(res)

          doc.css(".main_title").zip(doc.css(".recruit_footer a.entry_click")).each do |company_name, detail_link|
            company_hash = {}
            company_hash[:name] = company_name.content.split(" | ")[0]

            sleep 1
            detail_link = URI.join(base_url, detail_link["href"]).to_s.gsub("/msg", "")
            begin
              detail_doc = Nokogiri::HTML(open(detail_link))
            rescue => e
              p e
              next
            end

            case URI(detail_link).host
            when "tenshoku.mynavi.jp" then
              detail_doc.css(".thL tr > th").zip(detail_doc.css(".thL tr > td")).each do |th, td|
                key = th.content.strip
                data = td.content.strip
                case key
                when "設立" then
                  company_hash[:established_date] = data
                when "代表者" then
                  company_hash[:president_name] = data
                when "従業員数" then
                  company_hash[:employees] = data
                when "資本金" then
                  company_hash[:capital] = data
                when "本社所在地" then
                  company_hash[:address] = data
                when "企業ホームページ" then
                  company_hash[:web_url] = data
                end
              end
              detail_doc.xpath("//script/text()").each do |script|
                array = script.content.split(" ")
                num = array.index("jobInfo_planId")
                if num.present?
                  company_hash[:plan_id] = array[num + 2].delete(";").to_i #  var jobInfo_planId  が欲しい
                end
              end
              detail_doc.css(".dateInfo").each do |date_info|
                date_info.children.each do |date|
                  str = date.content
                  if str.include?("情報更新日")
                    company_hash[:edit_date] = str.delete("情報更新日：")
                  elsif str.include?("掲載終了予定日")
                    company_hash[:finish_date] = str.delete("掲載終了予定日：")
                  end
                end
              end
            when "mynavi.agentsearch.jp" then
              detail_doc.css(".table-e dl > dt").zip(detail_doc.css(".table-e dl > dd")).each do |dt, dd|
                key = dt.content.strip
                data = dd.content.strip
                case key
                when "設立" then
                  company_hash[:established_date] = data
                when "従業員数" then
                  company_hash[:employees] = data
                when "資本金" then
                  company_hash[:capital] = data
                end
              end
            else
              p "new host found! #{URI(detail_link).host}"
            end
            companies << MynaviTenshoku.new(company_hash)
          end
          MynaviTenshoku.import companies
          page += 1
        end
      end
    end
  end

  def crawling_pr_times(page: 1)
    base_url = "https://prtimes.jp"
    begin
      page = Integer(page)
    rescue => e
      raise "pageは数値で指定してください."
    end
    if page < 1 then
      raise "pageは1以上で指定してください"
    end

    while true do
      companies = []
      sleep 1
      pr_links = "#{base_url}/main/html/index/pagenum/#{page}"
      p "reading #{pr_links}"
      begin
        doc = Nokogiri::HTML(open(pr_links))
      rescue => e
        p e
        break
      end


      doc.css(".list-article__company-name-link").zip(doc.css(".list-article__company-name--dummy"), doc.css(".list-article__time"), doc.css(".list-article__link")).each do |detail_link, company_name, time, pr_url|
        company_hash = {}
        detail_link = URI.join(base_url, detail_link["href"])
        company_hash[:name] = company_name.content.strip
        company_hash[:pr_datetime] = time["datetime"].to_datetime
        company_hash[:pr_url] = base_url + pr_url["href"]
        sleep 1
        begin
          detail_doc = Nokogiri::HTML(open(detail_link))
        rescue => e
          p e
          next
        end

        detail_doc.css(".head-information").zip(detail_doc.css(".body-information")).each do |head, body|
          key = head.content.strip
          data = body.content.strip
          case key
          when "URL" then
            company_hash[:web_url] = data
          when "業種" then
            company_hash[:sector] = data
          when "本社所在地" then
            company_hash[:address] = data
          when "電話番号" then
            company_hash[:phone_number] = data
          when "代表者氏名" then
            company_hash[:president_name] = data
          when "上場" then
            company_hash[:listed] = data
          when "資本金" then
            company_hash[:capital] = data
          end
        end
        companies << PrTime.new(company_hash)
      end
      PrTime.import companies
      page += 1
    end
  end

  def test_mynavi
    base_url = "https://next.rikunabi.com"
    search_link = "#{base_url}/lst/crn1.html"
    agent = Mechanize.new
    begin
      main_page = agent.get(search_link)
    rescue => e
      p e
    end
    search_form = main_page.form
    search_form['wrk_plc_long_cd'] = '0523000000'
    search_form['wrk_plc_long_cd'] = '0523100000'
    search_form['l_screen_id'] = 'cp_s00700'
    search_form['ov_wrt_aprvl_f'] = '0'
   search_form['h_ofc_f'] = '0'
    search_form['l_srch_id'] = 'cp_s00700'
    search_form['disp_cd'] = 'cp_s01990'
    doc = search_form.submit
    # p doc
    detail_links = []
      doc.search(".rnn-linkText--black").each do |detail_link|
        detail_link = URI.join(base_url, detail_link["href"].sub(/nx1/, 'nx2'))
        detail_links << detail_link
      end
    p doc.at('.rnn-pageNumber.rnn-textXl').content
  end
end

# l_screen_id: cp_s00700
# ov_wrt_aprvl_f: 0
# h_ofc_f: 0
# srch_ann_inc_cd_to:
#     keyword_input:
#     l_srch_id: cp_s00700
# galileo:
#     disp_cd: cp_s01990
# wrk_plc_long_cd: 0100000000
# srch_ann_inc_cd_from:
#
#     l_screen_id: cp_s00700
# ov_wrt_aprvl_f: 0
# h_ofc_f: 0
# srch_ann_inc_cd_to:
#     keyword_input:
#     l_srch_id: cp_s00700
# galileo:
#     disp_cd: cp_s01990
# wrk_plc_long_cd: 0202000000
# srch_ann_inc_cd_from:
#
#
