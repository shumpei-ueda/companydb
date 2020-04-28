class AddIsReflectedToYahooSources < ActiveRecord::Migration[6.0]
  def change
    add_column :yahoo_sources, :is_reflected, :integer
  end
end
