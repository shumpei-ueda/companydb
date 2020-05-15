class AddIndexDemoCompaniesPrtimesFlag < ActiveRecord::Migration[6.0]
  def change
    add_index :demo_companies, :prtimes_flag
  end
end
