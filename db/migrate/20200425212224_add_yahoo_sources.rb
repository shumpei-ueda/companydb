class AddYahooSources < ActiveRecord::Migration[6.0]
  def up
    add_column :yahoo_sources, :phone_number, :integer
    add_column :yahoo_sources, :industry_code, :integer
  end

  def down
    remove_column :yahoo_sources, :phone_number, :integer
    remove_column :yahoo_sources, :industry_code, :integer
  end
end
