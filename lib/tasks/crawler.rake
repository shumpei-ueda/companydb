namespace :crawler do
  desc "リクナビをクローリングする"
  task crawling_rikunabi: :environment do
    Crawler.crawling_rikunabi
  end
end
