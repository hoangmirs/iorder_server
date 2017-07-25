class Api::V1::UsersController < Api::V1::ApplicationController
  skip_before_action :doorkeeper_authorize!, only: :create

  def create
    user = User.new user_params
    if user.save
      render json: {data: Api::V1::GenerateTokenService.call(user)}, status: 200
    else
      render json: {data: {errors: user.errors.full_messages.first}}, status: 400
    end
  end

  def update

  end

  def destroy

  end

  private
  def user_params
    params.require(:user).permit :name, :gender, :email, :birthday, :address,
      :phone_number, :password, :password_confirmation
  end
end
