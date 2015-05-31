require 'spec_helper'

describe 'when a user is viewing its support duties' do
  before { Timecop.freeze 'Mon, 1 June 2015'.to_date }
  after { Timecop.return }

  let!(:sp) { SupportDuty.create user: user, assigned_at: default_date, state: state }
  let(:user) { User.create name: 'user' }
  let(:default_date) { Time.zone.now + 1.day }

  context 'when support duty is active' do
    let(:state) { 'active' }
    it do
      visit "/users/#{user.id}"

      expect(page).to have_content sp.assigned_at.to_date
      expect(page).to have_content user.name
      expect(page).to have_link 'mark as unavailable', "/users/#{user.id}/support_duties/#{sp.id}/edit"
    end
  end
end