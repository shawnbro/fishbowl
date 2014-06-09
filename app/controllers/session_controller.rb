class SessionController < ApplicationController
  def new
    redirect_to controller: :appointments, action: :index if session[:user_id] 
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to controller: :appointments, action: :index
    else
      @message = 'Incorrect Email & Password Combination'
      render :new
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end
end