class CreateCompanyData < ActiveRecord::Migration[6.0]
  def change
    create_table :company_data do |t|
      t.string :name
      t.integer :corporate_num
      t.string :prefecture
      t.string :city
      t.string :address
      t.string :established_date

      t.timestamps
    end
  end
end
