class App
  include Mongoid::Document

  # Main properties
  field :name
  field :app_type_id, type: Integer

  # Relations
  has_many :errors

  # Validations
  validates :name, presence: true

end
