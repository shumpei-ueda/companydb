class CreatePrTimes < ActiveRecord::Migration[6.0]
  def change
    create_table :pr_times do |t|
      t.string :name
      t.datetime :pr_datetime
      t.string :web_url
      t.string :sector
      t.string :address
      t.string :phone_number
      t.string :president_name
      t.string :listed
      t.string :capital


      t.timestamps
    end
  end
end
