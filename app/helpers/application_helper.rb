module ApplicationHelper
  def site_slug
    Rails.application.class.module_parent_name.underscore.dasherize
  end

  def nav_link_class(path)
    class_names("text-body", "text-decoration-none", "nav-current" => current_page?(path))
  end
end
