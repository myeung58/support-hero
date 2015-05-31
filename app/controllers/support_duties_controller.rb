class SupportDutiesController < ApplicationController
  before_action :find_support_duty, only: [:edit, :update]

  def index
    @support_duties = SupportDuty.available
  end

  def edit
    @support_duties = SupportDuty.available
  end

  def update
    if @support_duty.reschedule_with reschedulable
      flash[:success] = "Support Duty has been rescheduled to #{reschedulable.assigned_at.to_date}"
      redirect_to [reschedulable.user]
    else
      flash[:alert] = "Failed to reschedule"
      redirect_to [:edit, @support_duty]
    end
  end

  private
  def find_support_duty
    @support_duty = SupportDuty.includes(:user).find params[:id]
  end

  def support_duties_params
    params.require(:support_duty).permit :reschedulable_id
  end

  def marking_date_unavailable?
    params.key? :user_id
  end

  def reschedulable
    return @support_duty.next if marking_date_unavailable?
    return unless support_duties_params.fetch(:reschedulable_id).present?
    SupportDuty.find support_duties_params.fetch :reschedulable_id
  end
end