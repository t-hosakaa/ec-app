class UsersController < ApplicationController

  before_action :nologin_user, {only: [:edit, :update, :logout_form]}
  before_action :noauthority_user, {only: [:show, :edit, :update, :logout_form]}

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/users/#{@user.id}"
      flash[:notice] = "新規登録しました"
    else
      render :new
      flash[:alert] = "登録に失敗しました"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to "/users/#{@user.id}"
      flash[:notice] = "更新しました"
    else
      render :edit
      flash[:alert] = "更新に失敗しました"
    end
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
      flash[:notice] = "ログインしました"
    else
      render :login_form
      flash[:alert] = "ログインに失敗しました"
    end
  end

  def logout_form
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
    flash[:notice] = "ログアウトしました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
