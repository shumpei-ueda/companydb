class CreateCompanyContactForms < ActiveRecord::Migration[6.0]
  def change
    create_table :company_contact_forms do |t|
      t.integer :company_id
      t.string :contact_form_url
      t.integer :source_id
      t.integer :is_invalid

      t.timestamps
    end
  end
end
