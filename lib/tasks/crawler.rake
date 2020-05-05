namespace :crawler do
  desc "リクナビをクローリングする"
  task crawling_rikunabi: :environment do
    Crawler.crawling_rikunabi
  end

  desc "マイナビ転職をクローリングする"
  task crawling_mynavi_tenshoku: :environment do
    Crawler.crawling_mynavi_tenshoku
  end

  desc "PR TIMESをクローリングする"
  task crawling_pr_times: :environment do
    Crawler.crawling_pr_times
  end
end
