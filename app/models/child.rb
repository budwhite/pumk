class Child < ActiveRecord::Base
  attr_accessible :first_name, :grade, :last_name, :name, :teacher

  belongs_to :user
end
