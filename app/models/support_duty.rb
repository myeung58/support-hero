class SupportDuty < ActiveRecord::Base
  belongs_to :user

  validates :assigned_at, presence: true

  delegate :token, :name, to: :user, prefix: true

  scope :active, -> { where(state: 'active').sort_by &:assigned_at }
  scope :unavailable, -> { where(state: 'unavailable').sort_by &:assigned_at }

  attr_accessor :reschedulable_id

  state_machine initial: :active do
    event(:start) { transition active: :current }
    event(:complete) { transition curent: :completed }
    event(:mark_unavailable) { transition any - :completed => :unavailable }
  end

  def self.schedule_for rotation
    return unless rotation.present?

    rotation.map do |user_name|
      create user: User.find_by(name: user_name), assigned_at: DutySchedulePolicy.new.next_schedulable_date
    end
  end

  def self.following duty
    where("assigned_at > ?", duty.assigned_at).order("assigned_at ASC").first
  end

  def reschedule_with reschedulable_support_duty
    return unless DutyReschedulePolicy.new(self, reschedulable_support_duty).can_reschedule?

    reschedulable_user = reschedulable_support_duty.user

    return unless mark_current_duty_unavailable
    assign_current_user_to reschedulable_support_duty
    reassign_duty_for reschedulable_user
  end

  def mark_current_duty_unavailable
    self.mark_unavailable!
  end

  def assign_current_user_to duty
    duty.update user: user
  end

  def reassign_duty_for user
    SupportDuty.create user: user, assigned_at: self.assigned_at
  end

  # can perhaps add a SupportDutyDecorator as an extra layer to store presentation logic, but currently this is probably too simple to justify it
  def choice_option
    "#{assigned_at.to_date.to_s} (#{user_name})"
  end
end
