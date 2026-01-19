class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]
  before_action :require_instructor_or_admin!, except: %i[index show]
  before_action :authorize_course_owner!, only: %i[edit update destroy]

  def index
    @published_courses = Course.includes(:instructor, :lessons, :enrollments).published.order(created_at: :desc)
    @my_courses = current_user&.instructor? || current_user&.admin? ? current_user.courses.includes(:enrollments, :lessons) : []
  end

  def show
    @lessons = @course.lessons.includes(:rich_text_content)
    @enrollment = current_user.enrollments.find_by(course: @course) if current_user&.student?
    @progress_percent = current_user ? @course.progress_for(current_user) : 0
  end

  def new
    @course = current_user.courses.build
  end

  def edit; end

  def create
    @course = (current_user.admin? && course_params[:instructor_id].present?) ? Course.new(course_params) : current_user.courses.build(course_params.except(:instructor_id))
    @course.instructor ||= current_user

    if @course.save
      redirect_to @course, notice: "Course created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    attrs = current_user.admin? ? course_params : course_params.except(:instructor_id)
    if @course.update(attrs)
      redirect_to @course, notice: "Course updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_path, notice: "Course removed."
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def authorize_course_owner!
    return if current_user.admin? || @course.instructor == current_user

    redirect_to courses_path, alert: "You cannot modify this course."
  end

  def course_params
    params.require(:course).permit(:title, :description, :status, :thumbnail, :instructor_id)
  end
end
