class ChangeDataCorporateNumToCompanyData < ActiveRecord::Migration[6.0]
  def change
    change_column :company_data, :corporate_num, :integer, :limit => 8
  end
end
