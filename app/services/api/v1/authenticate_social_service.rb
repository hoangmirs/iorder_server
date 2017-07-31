class Api::V1::AuthenticateSocialService < BaseService
  attr_reader :user

  def initialize params
    @name = params[:name]
    @email = params[:email]
    @uid = params[:uid]
    @provider = params[:provider]
  end

  def call
    return unless params_require_exist? || params_require_valid?
    User.authenticate_from_sns email: @email, name: @name, provider: @provider, uid: @uid
  end

  private
  def params_require_exist?
    @name && @email && @uid && @provider
  end

  def params_require_valid?
    User.providers.keys.include? @provider
  end
end
