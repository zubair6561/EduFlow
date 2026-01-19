class CreateLessons < ActiveRecord::Migration[7.1]
  def change
    create_table :lessons do |t|
      t.string :title, null: false
      t.integer :position, null: false, default: 1
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end

    add_index :lessons, [:course_id, :position]
  end
end
