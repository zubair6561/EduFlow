class LessonProgressesController < ApplicationController
  before_action :require_student!

  def update
    lesson = Lesson.find(params[:lesson_id])
    course = lesson.course

    unless current_user.enrolled_courses.include?(course)
      return redirect_to course_path(course), alert: "Enroll to track progress."
    end

    progress = current_user.lesson_progresses.find_or_initialize_by(lesson:)
    progress.completed = ActiveModel::Type::Boolean.new.cast(params[:completed])

    redirect_to lesson_path(lesson), notice: progress.save ? "Progress updated." : "Could not update progress."
  end
end
