class ChangeDataCorporateNumToCompany < ActiveRecord::Migration[6.0]
  def change
    change_column :companies,:corporate__num,:integer,limit: 8
  end
end
