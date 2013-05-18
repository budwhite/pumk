class RideStatusMailer < ActionMailer::Base
  default from: "notification@pickupmykid.com"

  def ride_posted
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def ride_booked(booker, ride)
    @booker = booker
    @driver = ride.driver
    child_id = ride.riderships.where(user_id: booker.id).first.child_id
    @child = Child.find(child_id)
    @greeting = "Hi"

    mail to: @driver.email, subject: @booker.first_name + ' has booked your ride!'
  end

  def ride_offered(offerer, ride)
    @offerer = offerer
    @rider = ride.riders.first
    @greeting = "Hi"

    mail to: @rider.email, subject: @offerer.first_name + ' has offered to pick up your kid!'
  end

  def ride_accepted(booker, ride)
    @booker = booker
    @driver = ride.driver
    @greeting = "Hi"

    mail to: @booker.email, subject: @driver.first_name + ' has accepted your ride request!'
  end
  
  def offer_accepted(offerer, rider)
    @offerer = offerer
    @rider = rider
    @greeting = "Hi"

    mail to: @offerer.email, subject: rider.first_name + ' has accepted your offer to pick up' + rider.first_name + "'s kid!"
  end

  def ride_canceled
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
