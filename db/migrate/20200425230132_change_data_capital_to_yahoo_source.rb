class ChangeDataCapitalToYahooSource < ActiveRecord::Migration[6.0]
  def change
    change_column :yahoo_sources, :capital, :integer, limit: 8
  end
end
