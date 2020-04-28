class CreateCompanyIndustries < ActiveRecord::Migration[6.0]
  def change
    create_table :company_industries do |t|
      t.integer :company_id
      t.integer :industry_id
      t.integer :source_id
      t.integer :is_invalid

      t.timestamps
    end
  end
end
