class Schedules < ActiveRecord::Migration[6.0]
  def change
    drop_table :schedules
  end
end
