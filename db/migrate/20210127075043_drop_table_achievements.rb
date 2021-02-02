class DropTableAchievements < ActiveRecord::Migration[6.0]
  def change
    drop_table :achievements
  end
end
