class CreateStackTags < ActiveRecord::Migration[6.0]
  def change
    create_table :stack_tags do |t|
      t.references :stack, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
  end
end
