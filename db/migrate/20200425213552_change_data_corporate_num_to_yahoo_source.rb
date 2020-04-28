class ChangeDataCorporateNumToYahooSource < ActiveRecord::Migration[6.0]
  def change
    change_column :yahoo_sources, :corporate_num, :integer , limit: 8
  end
end
