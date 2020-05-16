namespace :input_data do
  desc "県名を登録する"
  task input_prefecture: :environment do
    InputData.input_prefecture
  end

  desc "市名を登録する"
  task input_city: :environment do
    InputData.input_city
  end

  desc "csvから会社を登録する"
  task input_company_from_csv: :environment do
    InputData.input_company_from_csv
  end

  desc "テスト"
  task input_to_demo: :environment do
    InputData.input_to_demo
  end

end
