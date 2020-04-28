class ChangeDataPhoneNumberToYahooSource < ActiveRecord::Migration[6.0]
  def change
    change_column :yahoo_sources, :phone_number, :string
  end
end
