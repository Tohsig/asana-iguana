module ApplicationHelper
  def full_title(page_title='')
    base_title = "Asana Iguana"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def header_left_link
    if session[:api_key].empty?
      link_to 'Asana Iguana!', root_path
    else
      link_to 'Clear API Key', root_path
    end
  end
end
