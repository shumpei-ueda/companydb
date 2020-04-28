namespace :company do
  desc "twitterのハッシュタグから画像を保存するタスク"
  task get_companies_from_api: :environment do
    GetCompanies.get_from_yahoo_api
  end
end
