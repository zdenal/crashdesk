class Error
  include Mongoid::Document

  # Main properties
  field :crc
  field :hash_id
  field :title
  field :backtrace, type: Hash

  # Our properties for managing error
  field :no, type: Integer
  field :tags, type: Array
  field :persons, type: Array
  field :deadline, type: Date

  # Relations
  embeds_many :error_info
  belongs_to :app

end
