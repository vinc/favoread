class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :provider, type: String
  field :uid, type: String

  field :name, type: String
  field :email, type: String

  validates_presence_of :name
  validates_presence_of :email, on: :update

  def self.find_or_create_from_auth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.name = auth.info.name
    end
  end
end
