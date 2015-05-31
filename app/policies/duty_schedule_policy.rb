class DutySchedulePolicy
  def initialize
    @attempt_date = SupportDuty.last.try(:assigned_at) || Time.zone.now
  end

  def next_schedulable_date
    loop do
      next_available_date && next if date_taken?
      next_available_date && next unless date_eligible?
      break
    end
    @attempt_date
  end

  private
  def next_available_date
    @attempt_date += 1.day
  end

  def date_taken?
    SupportDuty.find_by assigned_at: @attempt_date
  end

  def date_eligible?
    !weekend? && !holiday?
  end

  def weekend?
    @attempt_date.saturday? || @attempt_date.sunday?
  end

  def holiday?
    ::STATE_HOLIDAYS.include? @attempt_date.to_date
  end
end