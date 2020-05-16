class ChangeDataTypeToDemoCompany < ActiveRecord::Migration[6.0]
  def change
    change_column :demo_companies, :capital, :string
    change_column :demo_companies, :employee, :string
  end
end
