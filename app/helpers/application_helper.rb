module ApplicationHelper
  def avatar_url(profile)
    if profile.avatar_url.present?
      profile.avatar_url
    else
      default_url = "app/assets/images/guest.png"
      gravatar_id  = Digest::MD5.hexdigest(profile.user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
    end
  end
end

