namespace :support_duties do
  desc 'update support duty states to reflect current date'
  task update_state: :environment do
    SupportDuty.current.each do |support_duty|
      support_duty.complete! if support_duty.can_complete?
      support_duty.next.start! if support_duty.next
    end
  end
end
