class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :username, :preferred_name, :twiki_name, :email, :provider

  has_many :news_items
  validates_associated :news_items

  validates :username,
              :presence => { :message => "You need to have a username" },
              :uniqueness => { :message => "Sorry that username has already been taken" }
  validates :email,
              :uniqueness => { scope: [:provider], :message => "That email is already in use in the system" }
  validate :email_or_twiki_unless_oauth

  def self.from_omniauth(auth)
    where(provider: auth["provider"], username: auth["uid"]).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.username = auth["uid"]
      user.preferred_name = auth["info"]["nickname"]
      user.provider = auth["provider"]
    end
  end

  private

  def email_or_twiki_unless_oauth
    if email.blank? && twiki_name.blank? && provider.blank?
      errors[:base] << "both email and twiki name can't be blank"
    end
  end

end