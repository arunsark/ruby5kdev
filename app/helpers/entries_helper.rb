module EntriesHelper
  def current_user_is_creator_of_entry?(entry)
    entry.user == current_user && !current_user.nil?
  end

  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.email, class: "gravatar")
  end
end
