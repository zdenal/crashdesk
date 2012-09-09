class App
  include Mongoid::Document

  # Main properties
  field :name
  field :app_type_id, type: Integer
  field :uuid
  field :created_at, type: Time, default: ->{ Time.now }

  # Relations
  has_many :errors
  has_and_belongs_to_many :user

  # Validations
  validates :name, presence: true

  before_create :generate_uuid

  def generate_uuid
    self.uuid = UUID.generate
  end

end
