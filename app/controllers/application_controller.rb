class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  add_flash_types :success, :info, :warning

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[full_name role])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[full_name])
  end

  def after_sign_in_path_for(_resource)
    dashboard_path
  end

  def require_admin!
    redirect_to dashboard_path, alert: "Admins only." unless current_user&.admin?
  end

  def require_instructor!
    redirect_to dashboard_path, alert: "Instructors only." unless current_user&.instructor? || current_user&.admin?
  end

  def require_student!
    redirect_to dashboard_path, alert: "Students only." unless current_user&.student?
  end

  def require_instructor_or_admin!
    redirect_to dashboard_path, alert: "Admins or instructors only." unless current_user&.admin? || current_user&.instructor?
  end
end
