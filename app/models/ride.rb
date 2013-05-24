class Ride < ActiveRecord::Base
  include IceCube
  serialize :schedule, Hash

  attr_accessor :creator_type, #creator of ride, is she driver or rider?
    :origin, :destination, :time, :time1, :excluding_day, :from_date, :to_date,
    :for_which_child, :recurring_rules

  attr_accessible :destination_address_id, :driver_id, :gas_money, :origin_address_id, :schedule, :seats_filled, :seats_total, :ride_type, :comment, :created_by, :created_as

  # this allows for queries like: @ride.driver
  belongs_to :driver, class_name: 'User'

  # this allows for queries like: @ride.riders
  has_many :riderships, dependent: :destroy
  has_many :riders, source: :user, through: :riderships, uniq: true

  # @ride.origin_address
  belongs_to :origin_address, class_name: 'Address'

  # @ride.destination_address
  belongs_to :destination_address, class_name: 'Address'

  RIDE_TYPES = ['Drop-off', 'Pick-up']

  validates :ride_type, :seats_total, :origin_address_id, :destination_address_id, :gas_money, :schedule, presence: true

  def schedule=(new_schedule)
    write_attribute(:schedule, new_schedule.to_hash)
  end

  def schedule
    Schedule.from_hash(read_attribute(:schedule))
  end
end
