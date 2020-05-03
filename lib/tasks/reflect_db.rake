namespace :reflect_db do
  desc "YahooAPIから得たデータを本番に反映する"
  task reflect_from_yahoo_data: :environment do
    ReflectCompanies.reflect_from_yahoo
  end

  desc "YahooAPIから得たデータを本番に反映する"
  task reflect_from_yahoo_data_pro: :production do
    ReflectCompanies.reflect_from_yahoo
  end
end
