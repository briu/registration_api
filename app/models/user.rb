class User < ActiveRecord::Base
  before_save :ensure_authentication_token
  after_save :take_friends
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  attr_accessible :email, :password, :first_name, :last_name
  has_many :authentications

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

  def take_friends
    if self.provider == "facebook"
      user = FbGraph::User.me(@user.token).fetch
  end
end
