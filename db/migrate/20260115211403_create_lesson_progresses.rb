class CreateLessonProgresses < ActiveRecord::Migration[7.1]
  def change
    create_table :lesson_progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true
      t.boolean :completed, null: false, default: false

      t.timestamps
    end

    add_index :lesson_progresses, [:user_id, :lesson_id], unique: true
  end
end
