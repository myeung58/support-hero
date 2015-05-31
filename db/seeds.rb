SUPPORT_HERO_ROTATION.uniq.map do |hero_name|
  User.create name: hero_name
end

users = User.all

SupportDuty.schedule_for SUPPORT_HERO_ROTATION