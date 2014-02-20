require 'pry'
require 'pry-nav'

class User < ActiveRecord::Base

validates :email, uniqueness: true
validates :fullname, presence: true
validates :password, presence: true
# validate self.authenticate

  def self.authenticate(email, password)
    valid_user = User.where("email = ? AND password = ?", email, password).first
    valid_user

  end

end
