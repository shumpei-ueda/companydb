class AddIndexDemoCompaniesMynaviFlag < ActiveRecord::Migration[6.0]
  def change
    add_index :demo_companies, :mynavi_flag
  end
end
