class AddHabitToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :habit, :string
  end
end
