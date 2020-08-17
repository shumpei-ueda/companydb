namespace :crawler do
  desc "リクナビをクローリングする"
  task crawling_rikunabi: :environment do
    Crawler.crawling_rikunabi
  end

  desc "マイナビ転職をクローリングする"
  task :crawling_mynavi_tenshoku, ['_region', '_is_only', '_page'] => :environment do |task, args|
    Crawler.crawling_mynavi_tenshoku(args)
  end

  desc "PR TIMESをクローリングする"
  task :crawling_pr_times, ['page'] => :environment do |task, args|
    Crawler.crawling_pr_times(args)
  end

  desc "テスト"
  task :test, ['page'] => :environment do
    Crawler.test_mynavi
  end
end
