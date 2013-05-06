class Ridership < ActiveRecord::Base
  attr_accessible :ride_id, :user_id, :status

  belongs_to :ride
  belongs_to :user
end
