class CreateStacks < ActiveRecord::Migration[6.0]
  def change
    create_table :stacks do |t|
      t.datetime     :date,      null: false
      t.text         :text,      null: false
      t.integer      :work_time, null: false
      t.references   :user,      foreign_key: true
      t.timestamps
    end
  end
end
