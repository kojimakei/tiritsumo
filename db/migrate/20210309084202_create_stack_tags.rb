class CreateStackTags < ActiveRecord::Migration[6.0]
  def change
    create_table :stack_tags do |t|

      t.timestamps
    end
  end
end
