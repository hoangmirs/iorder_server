module ApplicationHelper
  def active_class link_path
    "active" if request.original_fullpath.include? link_path
  end
end
