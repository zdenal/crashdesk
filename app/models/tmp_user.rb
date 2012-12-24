class TmpUser
  include Mongoid::Document

  # Main properties
  field :email

  # Relations
  has_and_belongs_to_many :apps

  # Validations
  validates :email, email: true, allow_blank: false,
    uniqueness: true

  def create_user
  end

end
