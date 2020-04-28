class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :corporate__num
      t.date :established_date
      t.integer :source_id

      t.timestamps
    end
  end
end
