module Instructor
  class DashboardController < ApplicationController
    before_action :require_instructor_or_admin!

    def show
      @courses = (current_user.admin? ? Course.all : current_user.courses).includes(:lessons, :enrollments)
      @top_courses = @courses.sort_by { |c| -c.enrollments.size }.first(5)
      @progress_overview = @courses.map do |course|
        {
          course:,
          students: course.enrollments.count,
          lessons: course.lessons.count
        }
      end
    end
  end
end
