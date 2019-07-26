module ApplicationHelper
  def admin_logged_in?
    user_signed_in? && current_user.admin
  end

  def flash_alert_class(key)
    return 'alert-success' if key == 'notice'
    return 'alert-warning col-lg-6 offset-lg-3' if key == 'devise'
    return 'alert-warning'
  end

end
