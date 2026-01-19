class LessonsController < ApplicationController
  before_action :set_lesson, only: %i[show edit update destroy]
  before_action :set_course
  before_action :require_instructor_or_admin!, except: %i[show]
  before_action :authorize_access!, only: %i[show]

  def show
    @progress = current_user.lesson_progresses.find_by(lesson: @lesson) if current_user&.student?
  end

  def new
    @lesson = @course.lessons.build
  end

  def edit; end

  def create
    @lesson = @course.lessons.build(lesson_params)
    @lesson.position ||= (@course.lessons.maximum(:position) || 0) + 1

    if @lesson.save
      redirect_to course_path(@course), notice: "Lesson created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to course_path(@course), notice: "Lesson updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lesson.destroy
    redirect_to course_path(@course), notice: "Lesson removed."
  end

  private

  def set_course
    @course ||= params[:course_id] ? Course.find(params[:course_id]) : @lesson&.course
  end

  def set_lesson
    @lesson = Lesson.find(params[:id]) if params[:id]
  end

  def lesson_params
    params.require(:lesson).permit(:title, :position, :content)
  end

  def authorize_access!
    return if current_user.admin? || current_user.instructor? || @course.published? && (current_user.student? ? (current_user.enrolled_courses.include?(@course) || @course.published?) : true)

    redirect_to courses_path, alert: "You don't have access to that lesson."
  end
end
