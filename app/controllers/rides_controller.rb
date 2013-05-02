class RidesController < ApplicationController
  include IceCube

  def index
    ride = Ride.find(params[:current_ride])
    if ride.driver_id == nil
      @rides = Ride.all.select { |r| r.driver_id != nil }
    else
      @rides = Ride.where(driver_id: nil).to_a
    end
  end

  def show
    @ride = Ride.find(params[:id])
  end

  def new
    @ride = Ride.new
  end

  def create
    ride = Ride.new

    if params[:ride][:creator_type].include? 'offering'
      ride.driver_id = current_user.id
      ride.seats_total = params[:ride][:seats_total]
      ride.seats_filled = 0
    end

    ride.status = 'posted'
    ride.gas_money = params[:ride][:gas_money]
    ride.ride_type = params[:ride][:ride_type]
    ride.origin_address_id = current_user.addresses.where(name: params[:ride][:origin])[0].id
    ride.destination_address_id = 
      Address.where(user_id:0).where(name: params[:ride][:destination])[0].id

    time_str = params[:ride][:from_date] + ' ' + params[:ride][:time]
    start_time = DateTime.strptime(time_str, '%m/%d/%Y %H:%M %P')
    weekdays = %w(monday tuesday wednesday thursday friday)
    excluded_day = params[:ride][:excluding_day]
    weekdays.delete_if { |x| x == excluded_day.downcase }
    end_date = Date.strptime(params[:ride][:to_date], '%m/%d/%Y')

    schedule = Schedule.new(start_time)
    schedule.add_recurrence_rule Rule.weekly.day(*weekdays.map(&:to_sym)).until(end_date)

    ride.schedule = schedule

    # need to create more schedule(s) to account for different times
    if excluded_day != 'None'
      time_str = params[:ride][:from_date] + ' ' + params[:ride][:time1]
      start_time = DateTime.strptime(time_str, '%m/%d/%Y %H:%M %P')

      schedule1 = Schedule.new(start_time)
      schedule1.add_recurrence_rule Rule.weekly.day(excluded_day.downcase.to_sym).until(end_date)
      ride.schedule1 = schedule1
    end

    if ride.save
      if params[:ride][:creator_type].include? 'looking'
        ride.riderships.create!(user_id: current_user.id, ride_id: ride.id)
      end
      flash[:success] = "Ride posted!"
      redirect_to user_path(current_user)
    else
      @ride = Ride.new
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
    ride = Ride.find(params[:id])
    ride.destroy
    flash[:success] = 'Ride canceled!'

    respond_to do |format|
      format.html { redirect_to user_path(current_user) }
      format.json { head :no_content }
    end
  end

  def book

  end
end
