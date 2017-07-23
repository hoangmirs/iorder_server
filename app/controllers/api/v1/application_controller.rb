class Api::V1::ApplicationController < ActionController::API
  before_action :doorkeeper_authorize!

  respond_to :json
end
