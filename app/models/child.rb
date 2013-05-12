class Child < ActiveRecord::Base
  attr_accessible :first_name, :grade, :last_name, :name, :teacher, :gender

  before_save do
    if self.gender == 'boy'
      self.gender = 'male'
    elsif self.gender == 'girl'
      self.gender = 'female'
    end
  end

  belongs_to :user

  validates :name, :grade, :teacher, presence: true

  GRADE_TYPES = %w(K 1 2 3 4 5 6)
  validates_inclusion_of :grade, in: GRADE_TYPES, message: "{{value}} must be in #{GRADE_TYPES.join ', '}" 

end
