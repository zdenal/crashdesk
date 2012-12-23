class App
  include Mongoid::Document

  # Main properties
  field :name
  field :app_type_id, type: Integer
  field :created_at, type: Time, default: ->{ Time.now }

  # Relations
  embeds_many :error_info
  has_and_belongs_to_many :users
  has_and_belongs_to_many :tmp_users

  # Validations
  validates :name, presence: true
  validates_uniqueness_of :name

  def remove_collaborator(collaborator)
    users.delete(collaborator)
    destroy unless users.exists?
  end

  def add_collaborator(collaborator)
    if has_collaborator?(collaborator)
      collaborator.errors.add(:email, 'Collaborator was already added')
      return false
    end
    # users & tmp_users has N-N has_and_belongs_to_many which
    # keep both sides of relation in sync, so we can easely use
    # this:
    collaborator.apps << self
    true
  end

  def has_collaborator?(collaborator)
    users.where(email: collaborator.email).exists? ||
      tmp_users.where(email: collaborator.email).exists?
  end

end
