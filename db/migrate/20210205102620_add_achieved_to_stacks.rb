class AddAchievedToStacks < ActiveRecord::Migration[6.0]
  def change
    add_column :stacks, :achieved, :boolean
  end
end
