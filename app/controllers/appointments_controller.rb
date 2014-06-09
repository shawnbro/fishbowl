class AppointmentsController < ApplicationController
  def index
    @user = User.find_by_id(session[:user_id])
    if @user
      @appointments = Appointment.all
      @weekdays = Date.today.all_week.to_a[0..4]
    else
      redirect_to controller: :session, action: :new
    end
  end

  def new
    @user = User.find_by_id(session[:user_id])
    if @user
      render :new
    else
      redirect_to controller: :session, action: :new
    end
  end

  def create
    @user = User.find_by_id(session[:user_id])
    @appointment = Appointment.new(
      date: params[:appointment][:date], 
      start_time: params[:appointment][:start_time], 
      end_time: params[:appointment][:end_time], 
      user_id: @user.id
    )
    if @appointment.save
      redirect_to appointments_path
    else
      @message = @appointment.errors.messages
      render :new
    end
  end

  def show

  end
  def new_week

    @weekdays = (Date.today + params[:week].to_i.week).all_week.to_a[0..4]
    render json: @weekdays.to_json
  end
end