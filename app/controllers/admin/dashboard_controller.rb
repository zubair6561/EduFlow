module Admin
  class DashboardController < ApplicationController
    before_action :require_admin!

    def show
      @user_count = User.count
      @course_count = Course.count
      @enrollment_count = Enrollment.count
      @recent_enrollments = Enrollment.includes(:user, :course).order(created_at: :desc).limit(8)
      @recent_courses = Course.includes(:instructor).order(created_at: :desc).limit(5)
    end
  end
end
