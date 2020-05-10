class CreateDemoCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :demo_companies do |t|
      t.string :name
      t.bigint :corporate_num
      t.bigint  :yahoo_flag
      t.string :phone_number
      t.string :address
      t.integer :postal_code
      t.integer :prefecture_id
      t.integer :city_id
      t.string :president_name
      t.bigint :capital
      t.bigint :employee
      t.string :listing
      t.integer :industry_id
      t.integer :sector_id
      t.string :facebook_url
      t.string :twitter_url
      t.string :web_url
      t.bigint :prtimes_flag
      t.string :prtimes_url
      t.bigint :mynavi_flag



      t.timestamps
    end
  end
end
