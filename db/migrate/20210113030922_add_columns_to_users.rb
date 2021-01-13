class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :goal,           :string,   null: false
    add_column :users, :deadline,       :datetime, null: false
    add_column :users, :age_id,         :integer
    add_column :users, :category_id,    :integer
    add_column :users, :occupation_id,  :integer
  end
end
