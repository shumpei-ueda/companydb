class CreateCompanyPrTimes < ActiveRecord::Migration[6.0]
  def change
    create_table :company_pr_times do |t|
      t.integer :company_id
      t.datetime :pr_datetime
      t.string :pr_url

      t.timestamps
    end
  end
end
