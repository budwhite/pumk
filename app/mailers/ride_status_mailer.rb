class RideStatusMailer < ActionMailer::Base
  default from: "notification@pickupmykid.com"

  def ride_posted
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def ride_booked(booker, ride)
    @booker = booker
    @driver = ride.driver
    @greeting = "Hi"

    mail to: @driver.email, subject: @booker.name + ' has booked your ride!'
  end

  def ride_accepted(booker, ride)
    @booker = booker
    @driver = ride.driver
    @greeting = "Hi"

    mail to: @booker.email, subject: @driver.name + ' has accepted your ride request!'
  end

  def ride_canceled
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
