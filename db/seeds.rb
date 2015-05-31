SUPPORT_HERO_ROTATION.uniq.map do |hero_name|
  User.create name: hero_name
end

SupportDuty.schedule_for SUPPORT_HERO_ROTATION