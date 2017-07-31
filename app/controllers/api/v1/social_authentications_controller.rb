class Api::V1::SocialAuthenticationsController < Api::V1::ApplicationController
  skip_before_action :doorkeeper_authorize!, only: :create

  def create
    user = Api::V1::AuthenticateSocialService.call user_params
    if user
      render json: {data: Api::V1::GenerateTokenService.call(user)}, status: 200
    else
      render json: {errors: I18n.t("errors.api.sessions_controller.login.failed")},
        status: 400
    end
  end

  private
  def user_params
    params.require(:user).permit :email, :uid, :name, :provider
  end
end
