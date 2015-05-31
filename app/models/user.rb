class User < ActiveRecord::Base
  has_many :support_duties

  validates :name, presence: true

  def available_on? date
    unavailable_dates.exclude? date
  end

  def unavailable_dates
    support_duties.unavailable.map &:assigned_at
  end
end
