class Admin::BaseController < ApplicationController
  add_breadcrumb I18n.t("admin.breadcrumbs.home").html_safe, :admin_root_path
end
