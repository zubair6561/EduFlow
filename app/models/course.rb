class Course < ApplicationRecord
  belongs_to :instructor, class_name: "User"

  has_many :lessons, -> { order(:position) }, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :user
  has_many :lesson_progresses, through: :lessons
  has_one_attached :thumbnail

  enum status: { draft: 0, published: 1 }

  validates :title, :description, presence: true

  def progress_for(user)
    return 0 if lessons.count.zero?

    completed = LessonProgress.where(user:, lesson_id: lessons.ids, completed: true).count
    ((completed.to_f / lessons.count) * 100).round
  end

  def total_completed_lessons(user)
    LessonProgress.where(user:, lesson_id: lessons.ids, completed: true).count
  end
end
