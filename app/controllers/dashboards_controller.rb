class DashboardsController < ApplicationController
  def redirect
    return redirect_to new_user_session_path unless current_user

    case current_user.role
    when "admin"
      redirect_to admin_dashboard_path
    when "instructor"
      redirect_to instructor_dashboard_path
    else
      redirect_to student_dashboard_path
    end
  end
end
