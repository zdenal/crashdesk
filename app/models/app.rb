class App
  include Mongoid::Document

  # Main properties
  field :name
  field :app_type_id, type: Integer
  field :created_at, type: Time, default: ->{ Time.now }

  # Relations
  embeds_many :error_info
  has_and_belongs_to_many :user

  # Validations
  validates :name, presence: true

end
