class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.datetime     :date,        null: false
      t.datetime     :begin_time,  null: false
      t.datetime     :finish_time, null: false
      t.string       :plan,        null: false
      t.references   :user,        foreign_key: true
      t.timestamps
    end
  end
end
