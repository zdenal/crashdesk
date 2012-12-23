class TmpUser
  include Mongoid::Document

  # Main properties
  field :email

  # Relations
  has_and_belongs_to_many :apps

  # Validations
  validates :email, presence: true
  validates_uniqueness_of :email

end
