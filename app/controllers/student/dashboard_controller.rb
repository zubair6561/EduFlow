module Student
  class DashboardController < ApplicationController
    before_action :require_student!

    def show
      @enrollments = current_user.enrollments.includes(course: :lessons)
      @progress = @enrollments.map do |enrollment|
        course = enrollment.course
        {
          course:,
          percent: course.progress_for(current_user),
          completed_lessons: course.total_completed_lessons(current_user),
          total_lessons: course.lessons.count
        }
      end
    end
  end
end
