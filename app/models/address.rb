class Address < ActiveRecord::Base
  attr_accessible :city, :latitude, :longitude, :name, :state, :street1, :street2, :zipcode

  has_many :rides_as_origin, :class_name => 'Ride', :foreign_key => 'origin_address_id'
  has_many :rides_as_destination, :class_name => 'Ride', :foreign_key =>'destination_address_id'
end
