
every 1.day, :at => '12:00 am' do
  rake 'support_duties:update_state'
end
