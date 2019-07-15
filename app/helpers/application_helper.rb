module ApplicationHelper
  def admin_logged_in?
    user_signed_in? && current_user.admin
  end
end
