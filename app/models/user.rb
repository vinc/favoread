class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :provider, type: String
  field :uid, type: String
  field :access_token, type: String
  field :access_secret, type: String

  field :name, type: String
  field :email, type: String

  has_many :tweets

  validates_presence_of :name
  validates_presence_of :email, on: :update

  def self.find_or_create_from_auth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.name = auth.info.name
      user.access_token = auth.credentials.token
      user.access_secret = auth.credentials.secret
    end
  end
end
