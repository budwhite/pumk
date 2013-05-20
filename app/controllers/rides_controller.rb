class RidesController < ApplicationController
  before_filter :authenticate_user!

  include IceCube

  def index
    @rides = Ride.all
  end

  def show
    @ride = Ride.find(params[:id])
  end

  def new
    @ride = Ride.new
  end

  def create
    ride = Ride.new
    ride.created_by = current_user.id

    if params[:ride][:creator_type].include? 'offering'
      ride.created_as = 'driver'
      ride.driver_id = current_user.id
      ride.seats_total = params[:ride][:seats_total]
      ride.seats_filled = 0
    else
      ride.created_as = 'rider'
      for_which_child_id = Child.first(
        conditions: ["lower(name) = ?", params[:ride][:for_which_child].downcase]).id
    end

    ride.gas_money = params[:ride][:gas_money]
    ride.ride_type = params[:ride][:ride_type]

    all_addresses = current_user.addresses + Address.where(user_id: 0).all 

    ride.origin_address_id = all_addresses.detect{|x| x.name == params[:ride][:origin]}.id
    ride.destination_address_id = all_addresses.detect{|x| x.name == params[:ride][:destination]}.id
    time_str = params[:ride][:from_date] + ' ' + params[:ride][:time]
    start_time = DateTime.strptime(time_str, '%m/%d/%Y %H:%M %P')
    #weekdays = %w(monday tuesday wednesday thursday friday)
    #excluded_day = params[:ride][:excluding_day]
    #weekdays.delete_if { |x| x == excluded_day.downcase }
    end_date = Date.strptime(params[:ride][:to_date], '%m/%d/%Y')

    schedule = Schedule.new(start_time)
    #schedule.add_recurrence_rule Rule.weekly.day(*weekdays.map(&:to_sym)).until(end_date)

    rule = params[:ride][:recurring_rules]
    if !rule.nil?
      schedule.add_recurrence_rule Rule.from_yaml(params[:ride][:recurring_rules]).until(end_date)
      ride.schedule = schedule
    end

    # need to create more schedule(s) to account for different times
    #if excluded_day != 'None'
      #time_str = params[:ride][:from_date] + ' ' + params[:ride][:time1]
      #start_time = DateTime.strptime(time_str, '%m/%d/%Y %H:%M %P')

      #schedule1 = Schedule.new(start_time)
      #schedule1.add_recurrence_rule Rule.weekly.day(excluded_day.downcase.to_sym).until(end_date)
      #ride.schedule1 = schedule1
    #end

    if ride.save
      if params[:ride][:creator_type].include? 'looking'
        ride.riderships.create!(
          user_id: current_user.id,
          ride_id: ride.id,
          status: 'created',
          child_id: for_which_child_id
        )
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

  def booking
    @ride = Ride.find(params[:id])
    child_name = params[:child_name]
    if !child_name.nil?
      @child = current_user.children.first(conditions: ["lower(name) = ?", params[:child_name].downcase])
    else
      @child = nil
    end
  end

  def booked
    if params[:user][:child_id].nil?
      offering = true
    else
      offering = false
    end
    current_user.update_attributes phone_number: params[:user][:phone_number]
    @booked_ride = Ride.find(params[:user][:booked_ride_id])

    if not offering
      # if I'm not already a rider and there are seats available
      if !(@booked_ride.riders.include? current_user) && @booked_ride.seats_total - @booked_ride.seats_filled > 0
        @booked_ride.riders << current_user
        current_user.riderships.where(ride_id: @booked_ride.id).first.update_attributes(
          status: 'booked',
          child_id: params[:user][:child_id],
          expiration: 1.day.from_now
        )
        @booked_ride.save
        RideStatusMailer.ride_booked(current_user, @booked_ride).deliver
      else
        raise 'user already a rider or no seats available'
      end
    else
      @booked_ride.driver = current_user
      @booked_ride.riderships.first.update_attributes(
        status: 'offered',
        expiration: 1.day.from_now
      )
      @booked_ride.save
      RideStatusMailer.ride_offered(current_user, @booked_ride).deliver
    end
  end

  def responding
    @ride = Ride.find(params[:id])
    @rider = User.find(params[:rider_id]) unless params[:rider_id].nil?
    @driver = User.find(params[:driver_id]) unless params[:driver_id].nil?
  end

  def responded
    responded_to_ride = Ride.find(params[:ride][:responded_to_ride_id])
    
    if params[:ride][:responded_to_rider_id].nil?
      @offering = true
      responded_to_driver = User.find(params[:ride][:responded_to_driver_id])
    else
      @offering = false
      responded_to_rider = User.find(params[:ride][:responded_to_rider_id])
    end

    if @offering
      @ridership = responded_to_ride.riderships.first
    else
      @ridership = responded_to_rider.riderships.where(ride_id: responded_to_ride.id).first
    end

    if params[:commit].downcase.include? 'accept'
      current_user.update_attributes(phone_number: params[:ride][:phone_number])
      @ridership.update_attributes(
        status: 'accepted',
        comment: params[:ride][:comment],
        expiration: nil
      )
      if @offering
        RideStatusMailer.offer_accepted(responded_to_driver, current_user).deliver
      else
        responded_to_ride.update_attributes(seats_filled: responded_to_ride.seats_filled + 1) unless (responded_to_ride.seats_total == responded_to_ride.seats_filled)
        RideStatusMailer.ride_accepted(responded_to_rider, responded_to_ride).deliver
      end

      #if current_user.paypal_email == nil
        #render :setup_paypal
      #end
    else
      # handle declined request
    end
  end

  def setup_paypal
  end

  def confirm
    ride = Ride.find(params[:ride_id])
    # if current user is ride's driver, then this is a case whereby current user
    # offers to be a driver, and the rider parent has accepted, and current user
    # is now confirming the acceptance
    if ride.driver == current_user
      @rider = ride.riders.first
      ride.riderships.first.update_attributes(status: 'confirmed')
    else
      @driver = ride.driver
      ride.riderships.where(user_id: current_user.id).first.update_attributes(status: 'confirmed')
    end
  end
end
