class RemoveCreatedAddFromCompanyData < ActiveRecord::Migration[6.0]
  def change

    remove_column :company_data, :created_at, :timestamps
    remove_column :company_data, :updated_at, :timestamps
  end
end
