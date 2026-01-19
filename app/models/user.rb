class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { admin: 0, instructor: 1, student: 2 }

  has_many :courses, foreign_key: :instructor_id, inverse_of: :instructor, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :enrolled_courses, through: :enrollments, source: :course
  has_many :lesson_progresses, dependent: :destroy
  has_many :completed_lessons, through: :lesson_progresses, source: :lesson

  validates :full_name, presence: true

  def display_role
    role.titleize
  end
end
