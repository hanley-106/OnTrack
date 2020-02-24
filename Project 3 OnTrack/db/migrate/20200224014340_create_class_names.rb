class CreateClassNames < ActiveRecord::Migration[6.0]
  def change
    create_table :class_names do |t|
      t.column :name, :string
      t.timestamps
    end
  end
end
