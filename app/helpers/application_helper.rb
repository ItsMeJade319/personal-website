module ApplicationHelper
  def site_slug
    Rails.application.class.module_parent_name.underscore.dasherize
  end

  def nav_link_class(path)
    class_names("text-body", "text-decoration-none", "nav-current" => current_page?(path))
  end

  # Only ever renders http(s) links, so an admin-entered URL can't be used
  # to inject a javascript: or data: href. Admins may type a bare domain
  # (e.g. "example.com") without a scheme; we assume https for those.
  def safe_url(url)
    return if url.blank?

    url = url.strip
    return url if url.match?(%r{\Ahttps?://\S+\z}i)
    return "https://#{url}" if url.match?(/\A[a-zA-Z0-9][^\s:]*\z/)
  end
end
