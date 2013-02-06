class User < ActiveRecord::Base
  attr_accessible :username, :preferred_name, :twiki_name, :email

  validates_presence_of :username, message: "You need to have a username"
  validate :email_or_twiki

  private

  def email_or_twiki
    if email.blank? && twiki_name.blank?
      errors[:base] << "both email and twiki name can't be blank"
    end
  end

end