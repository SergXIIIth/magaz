module ApplicationHelper

  def admin_favicon
    favicon_link_tag 'logo.png'
  end

  def admin_stylesheet
    stylesheet_link_tag "magaz/admin/application"
  end

  def admin_javascript
    javascript_include_tag "magaz/admin/application"
  end

end
