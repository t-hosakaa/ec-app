class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to "/users/#{user.id}"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to "/users/#{user.id}"
    else
      render 
    end
  end

  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to "/users/#{user.id}"
    else
      render '/login'
    end
  end

  def logout_form
  end

  def logout
    session[:user_id] = nil
    redirect_to '/logout'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
