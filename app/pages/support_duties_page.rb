class SupportDutiesPage
  attr_reader :context

  def initialize context
    @context = context
  end

  def support_duties
    SupportDuty.active
  end
end