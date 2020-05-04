class CreateMynaviTenshokus < ActiveRecord::Migration[6.0]
  def change
    create_table :mynavi_tenshokus do |t|
      t.string :name
      t.string :address
      t.string :president_name
      t.string :capital
      t.string :employees
      t.string :established_date
      t.string :web_url

      t.timestamps
    end
  end
end
