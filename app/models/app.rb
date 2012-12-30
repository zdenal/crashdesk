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

  def remove_collaborators(collaborators)
    # can't use delete_all with conditions or
    # users.where(:id.in => Array(collaborators).map(&:id)).delete_all, because
    # it delete also user himself. Didn't find the way
    # for mass deleting with automated sync on user site in 'user.apps'.
    Array(collaborators).each {|c| users.delete(c)}
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
