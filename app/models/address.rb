class Address < ActiveRecord::Base
  attr_accessible :name, :city, :state, :street1, :street2, :zipcode, :latitude, :longitude, :user_id, :address
  geocoded_by :full_street_address
  after_validation :geocode

  belongs_to :user
  has_many :rides_as_origin, :class_name => 'Ride', :foreign_key => 'origin_address_id'
  has_many :rides_as_destination, :class_name => 'Ride', :foreign_key =>'destination_address_id'

  VALID_ZIP_REGEX = /^\d{5}(-\d{4})?$/

  validates :user_id, :street1, :city, :state, :zipcode, presence: true

  # http://stackoverflow.com/questions/8212378/validate-us-zip-code-using-rails
  validates :zipcode, format: { :with => VALID_ZIP_REGEX, :message => 'should be in the form 12345 or 12345-1234' }

  def full_street_address
    [street1, city, state, zipcode].compact.join(', ')
  end
end
