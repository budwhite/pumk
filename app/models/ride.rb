class Ride < ActiveRecord::Base
  include IceCube
  serialize :schedule, Hash
  serialize :schedule1, Hash

  attr_accessor :creator_type, #creator of ride, is she driver or rider?
    :origin, :destination, :time, :time1, :excluding_day, :from_date, :to_date

  attr_accessible :destination_address_id, :driver_id, :gas_money, :origin_address_id, :schedule, :seats_filled, :seats_total, :status, :ride_type, :expiration, :comment

  # this allows for queries like: @ride.driver
  belongs_to :driver, :class_name => 'User'

  # this allows for queries like: @ride.riders
  has_many :riderships #, dependent: :restrict
  has_many :riders, :source => :user, :through => :riderships

  # @ride.origin_address
  belongs_to :origin_address, :class_name=>'Address'

  # @ride.destination_address
  belongs_to :destination_address, :class_name=>'Address'

  STATUSES = %w(posted booked confirmed canceled)
  validates_inclusion_of :status, :in => STATUSES,
    :message => "{{value}} must be in #{STATUSES.join ', '}"

  RIDE_TYPES = %w(Drop-off Pick-up)
  validates_inclusion_of :ride_type, :in => RIDE_TYPES,
    :message => "{{value}} must be in #{RIDE_TYPES.join ', '}"

  def schedule=(new_schedule)
    write_attribute(:schedule, new_schedule.to_hash)
  end

  def schedule1=(new_schedule)
    write_attribute(:schedule1, new_schedule.to_hash)
  end

  def schedule
    Schedule.from_hash(read_attribute(:schedule))
  end

  def schedule1
    Schedule.from_hash(read_attribute(:schedule1))
  end
end
