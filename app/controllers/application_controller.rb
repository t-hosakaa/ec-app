class ApplicationController < ActionController::Base

  def nologin_user
    current_user = User.find_by(id: session[:user_id])
    unless current_user
      redirect_to root_path
      flash[:alert] = "ログインしてください"
    end
  end

  def noauthority_user
    current_user = User.find_by(id: session[:user_id])
    if current_user != User.find_by(id: params[:id])
      redirect_to root_path
      flash[:alert] = "権限がありません"
    end
  end


end
