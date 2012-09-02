class App
  include Mongoid::Document

  # Main properties
  field :name
  field :app_type_id, type: Integer
  field :uuid

  # Relations
  has_many :errors

  # Validations
  validates :name, presence: true

  before_create :generate_uuid

end
