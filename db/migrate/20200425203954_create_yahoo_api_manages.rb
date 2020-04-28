class CreateYahooApiManages < ActiveRecord::Migration[6.0]
  def change
    create_table :yahoo_api_manages do |t|
      t.integer :next_start_id

      t.timestamps
    end
  end
end
