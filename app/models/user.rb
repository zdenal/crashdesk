class User
  include Mongoid::Document
  devise :rememberable, :trackable, :omniauthable, :registerable

  # Attrs
  attr_accessor :skip_email_validation

  ## Database authenticatable
  field :email
  field :name
  field :provider
  field :uid

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  # Validations
  validates :email, email: true, allow_blank: false,
    uniqueness: true, unless: :skip_email_validation

  has_and_belongs_to_many :apps

  def self.from_omniauth(auth)
    if Rails.env.development?
      auth.uid = auth.info.name
    end
    find_or_create_by(auth.slice(:provider, :uid)) do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      # for skip email validation now
      user.skip_email_validation = true
    end
  end

end
