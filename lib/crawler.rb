gem "activerecord-import"

require "uri"
require "open-uri"
require "nokogiri"

module Crawler extend self

  def crawling_rikunabi
    # 対象のURL
    @search_url = "https://job.rikunabi.com/2021/company/r544600011/"
    # Nokogiriで切り分け
    doc = Nokogiri::HTML(open(@search_url))

    c  =[]
    doc.search("td.ts-h-mod-dataTable02-cell").each do |a|
      c << a.content
      p a.content
    end
    p c[5]

    doc.search('//*[@id="company-data04"]/div/text()').each do |a|
      p a.content
    end

  end

  def crawling_mynavi_tenshoku
    base_url = "https://tenshoku.mynavi.jp"
    ["hokkaido", "tohoku", "kitakanto", "shutoken", "koshinetsu", "hokuriku", "tokai", "kansai", "chugoku", "shikoku", "kyushu", "global"].each do |region|
      for is_only in [false, true] do
        page = 1
        while true do
          companies = []
          sleep 1
          begin
            company_links = "#{base_url}/#{region}/list/#{ is_only ? "only/" : ""}#{ page > 1 ? "pg#{page}" : "" }"
            p "reading #{company_links}"
            res = open(company_links, { redirect: false })
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

  def crawling_pr_times
    base_url = "https://prtimes.jp/"
    page = 1


    while true do
      res = open(company_links, { redirect: false })
      begin
        pr_links = "#{base_url}/main/list/html/index/page"
        p "reading #{pr_links}"
        res = open(pr_links, { redirect: false })
      rescue => e
        p e
        break
      end



      page += 1
    end



  end

end
