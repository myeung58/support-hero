require "spec_helper"

describe "rescheduling a support duty" do
  before { Timecop.freeze "Mon, 1 June 2015".to_date }
  after { Timecop.return }

  let!(:sp1) { SupportDuty.create user: user1, assigned_at: default_date }
  let!(:sp2) { SupportDuty.create user: user2, assigned_at: assigned_date, state: state }
  let(:user1) { User.create name: "user1" }
  let(:user2) { User.create name: "user2" }
  let(:default_date) { Time.zone.now + 1.day }

  context "when both support duties are active" do
    let(:assigned_date) { Time.zone.now + 2.days }
    let(:state) { "active" }

    it do
      submit_reschedule_form sp1, sp2

      expect(page).to have_content "Support Duty has been rescheduled"
      expect(sp1.reload.state).to eq "unavailable"
      expect(sp2.reload.user).to eq user1
      expect(SupportDuty.last.user).to eq user2
    end
  end

  context "when one of the support duties are already completed" do
    let(:assigned_date) { Time.zone.now - 1.day }
    let(:state) { "completed" }

    it do
      submit_reschedule_form sp1, sp2

      expect(page).to have_content "Failed to reschedule"
      expect(sp1.user).to eq user1
    end
  end

  context "when there is no reschedulable support duty" do
    let!(:sp2) { nil }

    it do
      submit_reschedule_form sp1

      expect(page).to have_content "Failed to reschedule"
      expect(sp1.user).to eq user1
    end
  end

  context "when a user is marking a date as unavailable" do
    let(:assigned_date) { Time.zone.now + 2.days }
    let(:state) { "active" }

    it do
      mark_unavailable sp1

      expect(page).to have_content "Support Duty has been rescheduled"
      expect(sp1.reload.state).to eq 'unavailable'
      expect(sp2.reload.user).to eq user1
      expect(SupportDuty.last.user).to eq user2
    end
  end

  def submit_reschedule_form support_duty, target=nil
    visit "/support_duties/#{support_duty.id}/edit"

    select target.choice_option, from: "support_duty[reschedulable_id]" if target
    click_button "Submit"
  end

  def mark_unavailable support_duty
    visit "/users/#{user1.id}"
    click_link "mark as unavailable"
  end
end