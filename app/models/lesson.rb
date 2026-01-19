class Lesson < ApplicationRecord
  belongs_to :course
  has_rich_text :content

  has_many :lesson_progresses, dependent: :destroy
  has_many :students, through: :lesson_progresses, source: :user

  validates :title, presence: true
  validates :position, numericality: { greater_than: 0 }
end
