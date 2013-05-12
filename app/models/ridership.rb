class Ridership < ActiveRecord::Base
  attr_accessible :ride_id, :user_id, :status, :child_id, :expiration, :comment

  belongs_to :ride
  belongs_to :user
end
