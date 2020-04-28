class CreateCompanyTwitters < ActiveRecord::Migration[6.0]
  def change
    create_table :company_twitters do |t|
      t.integer :company_id
      t.string :url
      t.integer :is_invalid

      t.timestamps
    end
  end
end
