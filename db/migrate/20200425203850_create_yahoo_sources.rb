class CreateYahooSources < ActiveRecord::Migration[6.0]
  def change
    create_table :yahoo_sources do |t|
      t.integer :corporate_num
      t.string :name
      t.integer :postal_code
      t.string :address
      t.string :prefecture_name
      t.string :city_name
      t.string :president_name
      t.integer :capital
      t.integer :employees
      t.date :established_date
      t.integer :listed
      t.string :facebook_url
      t.string :twitter_url
      t.integer :president_phone_number
      t.string :web_url

      t.timestamps
    end
  end
end
