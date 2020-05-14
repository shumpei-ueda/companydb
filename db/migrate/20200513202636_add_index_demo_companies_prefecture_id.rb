class AddIndexDemoCompaniesPrefectureId < ActiveRecord::Migration[6.0]
  def change
    add_index :demo_companies, :prefecture_id
  end
end
