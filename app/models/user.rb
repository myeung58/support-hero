class User < ActiveRecord::Base
  has_many :support_duties

  validates :name, :token, presence: true
  validates :token, uniqueness: true
end
