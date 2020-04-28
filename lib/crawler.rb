module Crawler  extend self

require "open-uri"
require "nokogiri"

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

end