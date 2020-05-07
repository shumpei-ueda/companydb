namespace :reflect_db do
  desc "YahooAPIから得たデータを本番に反映する"
  task reflect_from_yahoo_data: :environment do
    ReflectCompanies.reflect_from_yahoo
  end
  desc "マイナビ転職から得たデータを本番に反映する"
  task reflect_from_mynavi_tenshoku: :environment do
    ReflectCompanies.reflect_from_mynavi_tenshoku
  end

end
