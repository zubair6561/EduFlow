class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :status, null: false, default: 0
      t.references :instructor, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :courses, :status
  end
end
