# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"
# 1番上に1度だけ記述　

# 以下は各テーブルごとに名前を変えて記述。例えばこれはordersテーブル。
orders_csv = CSV.readlines("db/yahoo_sources.csv")
orders_csv.shift
orders_csv.each do |row|
  YahooSource.create(corporate_num: row[1], name: row[2], postal_code: row[3], address: row[4], prefecture_name: row[5],
                     city_name: row[6], president_name: row[7], capital: row[8], employees: row[9], established_date: row[10],
                     listed: row[11], facebook_url: row[12], twitter_url: row[13], president_phone_number: row[14],
                     web_url: row[15], phone_number: row[18],)
  # idを除くカラム名を記述する
end

# productsテーブル
products_csv = CSV.readlines("db/products.csv")
products_csv.shift
# 以下略