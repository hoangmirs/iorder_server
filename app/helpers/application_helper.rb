module ApplicationHelper
  def active_class link_path
    "active" if request.original_fullpath == link_path
  end

  def get_object_counter object, counter, page
    if (page = page.to_i) > 1
      (page - 1) * Settings.pagination_default.try(object.class.name.downcase.pluralize) + counter + 1
    else
      counter + 1
    end
  end
end
