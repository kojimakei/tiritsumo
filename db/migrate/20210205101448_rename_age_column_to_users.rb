class RenameAgeColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :age, :age_id
  end
end
