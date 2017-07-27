class Api::V1::SessionsController < Api::V1::ApplicationController
  skip_before_action :doorkeeper_authorize!, only: :create

  def create
    user = User.authenticate user_params
    if user
      render json: {data: Api::V1::GenerateTokenService.call(user)}, status: 200
    else
      render json: {errors: I18n.t("errors.api.sessions_controller.login.failed")},
        status: 400
    end
  end

  def destroy
    revoke_token_service = Api::V1::RevokeTokenService.new doorkeeper_token.token
    revoke_token_service.execute
    if revoke_token_service.success?
      render json: {}, status: 200
    else
      render json: {errors: revoke_token_service.errors}, status: 400
    end
  end

  private
  def user_params
    params.require(:user).permit :email, :password
  end
end
