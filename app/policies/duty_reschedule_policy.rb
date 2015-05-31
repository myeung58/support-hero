class DutyReschedulePolicy
  def initialize support_duty, target
    @support_duty = support_duty
    @target = target
  end

  def can_reschedule?
    return unless @target.present?
    in_valid_states && users_available
  end

  def in_valid_states
    @support_duty.active? && @target.active?
  end

  def users_available
     current_user_available? && target_user_available?
  end

  def current_user_available?
    return unless current_user = @support_duty.user
    current_user.available_on?(@support_duty.assigned_at)
  end

  def target_user_available?
    return unless target_user = @target.user
    target_user.available_on?(@target.assigned_at)
  end
end