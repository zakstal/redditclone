module ApplicationHelper

  def form_auth
    <<-HTML.html_safe
      <input type="hidden"
      name="authenticity_token"
      value="#{ form_authenticity_token }">
    HTML
  end

  def moderator?(id)
    current_user.id == id
  end

  def author?(id)
    current_user.id == id
  end

  def preview(text)
    preview = text.slice(0,20)
    preview += '...' if text.length > 20
    preview
  end
end
