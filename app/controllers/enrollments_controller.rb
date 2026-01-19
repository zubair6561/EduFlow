class EnrollmentsController < ApplicationController
  before_action :set_course, only: :create
  before_action :require_student!, only: :create

  def create
    enrollment = current_user.enrollments.find_or_initialize_by(course: @course)

    if enrollment.persisted?
      redirect_to course_path(@course), notice: "You're already enrolled."
    elsif enrollment.save
      redirect_to course_path(@course), notice: "Enrolled successfully."
    else
      redirect_to course_path(@course), alert: "Unable to enroll."
    end
  end

  def destroy
    enrollment = current_user.enrollments.find(params[:id])
    enrollment.destroy
    redirect_to courses_path, notice: "Enrollment removed."
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end
end
