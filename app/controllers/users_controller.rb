class UsersController < ApplicationController
  before_action :login_confirm

  #user's homepage controller
  def homepage

  end

  private
  def login_confirm
    if !user_signed_in?
      redirect_to new_user_session_path  # if the user is not signed in redirect him to sign in

    elsif current_user.admin == true
        redirect_to movies_path   #redirect admin to the admin homepage
    else
      return true
    end
  end
end
