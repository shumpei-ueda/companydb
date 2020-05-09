class AddDetailsToPrTimes < ActiveRecord::Migration[6.0]
  def change
    add_column :pr_times, :pr_url, :string
  end
end
