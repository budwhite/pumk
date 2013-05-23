class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :provider, :uid, :name, :email, :password, :password_confirmation, :remember_me, :addresses_attributes, :children_attributes, :phone_number, :paypal_email, :gender, :first_name, :last_name, :verified, :avatar

  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true

  has_many :children, dependent: :destroy
  accepts_nested_attributes_for :children, allow_destroy: true

  # this allows for queries like: @user.rides_as_driver
  has_many :rides_as_driver, :class_name => 'Ride', :foreign_key => 'driver_id'
  has_many :riderships, dependent: :restrict
  # @user.rides_as_rider
  has_many :rides_as_rider, :source => :ride, :through => :riderships

  validates :first_name, :last_name, presence: true

  mount_uploader :avatar, AvatarUploader

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.image = auth.info.image
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.gender = auth.extra.raw_info.gender
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def profile_photo(type = 'normal')
    '/assets/cc_logo_' + type + '.png'
    #self.image.split('=')[0] << "=#{type}"
  end
end
