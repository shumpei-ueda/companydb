class CreateCompanyWebUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :company_web_urls do |t|
      t.string :url
      t.integer :source_id
      t.integer :is_invalid
      t.integer :company_id

      t.timestamps
    end
  end
end
