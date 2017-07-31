class Api::V1::ApplicationController < ActionController::API
  before_action :doorkeeper_authorize!
  before_action :current_user

  def doorkeeper_unauthorized_render_options error
    {json: {errors: I18n.t("doorkeeper.errors.messages.unauthorized_client", uid: current_user&.uid)}}
  end

  def current_user
    @current_user ||= User.find_by(id: doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
