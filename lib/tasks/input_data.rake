namespace :input_data do
  desc "県名を登録する"
  task input_prefecture: :environment do
    InputData.input_prefecture
  end

  desc "市名を登録する"
  task input_prefecture: :environment do
    InputData.input_city
  end
end
