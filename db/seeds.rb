SUPPORT_HERO_ROTATION.uniq.map do |hero_name|
  User.create name: hero_name, token: SecureRandom.urlsafe_base64
end