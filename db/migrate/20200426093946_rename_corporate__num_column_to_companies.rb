class RenameCorporateNumColumnToCompanies < ActiveRecord::Migration[6.0]
  def change
    rename_column :companies,:corporate__num,:corporate_num
  end
end
