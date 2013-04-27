class Ride < ActiveRecord::Base
  include IceCube
  serialize :schedule

  attr_accessible :destination_address_id, :driver_id, :gas_money, :origin_address_id, :schedule, :seats_filled, :seats_total, :status, :ride_type

  # this allows for queries like: @ride.driver
  belongs_to :driver, :class_name => 'User'

  # this allows for queries like: @ride.riders
  has_many :riderships, dependent: :restrict
  has_many :riders, :source => :user, :through => :riderships

  # @ride.origin_address
  belongs_to :origin_address, :class_name=>'Address'

  # @ride.destination_address
  belongs_to :destination_address, :class_name=>'Address'

end
