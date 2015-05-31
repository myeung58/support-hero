require 'spec_helper'

describe DutySchedulePolicy, '#next_schedulable_date' do
  subject { DutySchedulePolicy.new.next_schedulable_date }

  # set system time to and freeze at specified date; return to normal after test is run
  before { Timecop.freeze taken_date }
  after { Timecop.return }

  let!(:duty) { SupportDuty.create assigned_at: taken_date, user: user }
  let(:user) { User.create name: 'Michael' }
  let(:taken_date) { 'Mon, 1 June 2015'.to_date }
  let(:available_date) { 'Tues, 2 June 2015'.to_date }

  it { expect(subject.to_date).to eq available_date }
end