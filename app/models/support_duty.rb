class SupportDuty < ActiveRecord::Base
  belongs_to :user

  validates :assigned_at, presence: true

  delegate :token, to: :user, prefix: true
end
