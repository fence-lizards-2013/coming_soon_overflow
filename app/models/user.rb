class User < ActiveRecord::Base
  has_many :posts
  has_many :votes

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :remember_me

  validates :password_confirmation, :presence => true

  def avatar
    "http://www.gravatar.com/avatar/" + Digest::MD5.hexdigest(self.email) + "?s=200"
  end

end
