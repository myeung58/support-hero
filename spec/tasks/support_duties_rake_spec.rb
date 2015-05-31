require 'spec_helper'

describe 'support_duties', 'update_state' do
  before { Timecop.freeze "Mon, 1 June 2015".to_date }
  after { Timecop.return }

  let!(:duty1) { SupportDuty.create assigned_at: "Mon, 1 June 2015", state: state1 }
  let!(:duty2) { SupportDuty.create assigned_at: "Tue, 2 June 2015".to_date, state: state2 }

  before { Rake::Task['support_duties:update_state'].reenable }

  context 'states need updating' do
    let(:state1) { 'current' }
    let(:state2) { 'active' }

    it do
      Rake.application.invoke_task 'support_duties:update_state'

      expect(duty1.reload.state).to eq 'completed'
      expect(duty2.reload.state).to eq 'current'
    end
  end

  context 'states should remain as active' do
    let(:state1) { 'active' }
    let(:state2) { 'active' }

    it do
      Rake.application.invoke_task 'support_duties:update_state'

      expect(duty1.reload.state).to eq 'active'
      expect(duty2.reload.state).to eq 'active'
    end
  end
end