class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/login")
    end
  end

  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      if @current_user.mentor
        redirect_to("/mentors/#{@current_user.mentor.id}/")
      else
        redirect_to("/students/#{@current_user.student.id}/")
      end

    end
  end


end
