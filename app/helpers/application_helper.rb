module ApplicationHelper
  def site_slug
    Rails.application.class.module_parent_name.underscore.dasherize
  end

  def nav_link_class(path)
    class_names("text-body", "text-decoration-none", "nav-current" => current_page?(path))
  end

  # Only ever renders http(s) links, so an admin-entered URL can't be used
  # to inject a javascript: or data: href.
  def safe_url(url)
    url if url.present? && url.match?(%r{\Ahttps?://\S+\z}i)
  end
end
