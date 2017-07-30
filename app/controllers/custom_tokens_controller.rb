class CustomTokensController < Doorkeeper::TokensController

  def create
    super
    token_info = JSON.parse response.body
    if params[:refresh_token]
      created_at = token_info["created_at"]
      token_info["created_at"] = Time.zone.at created_at
      token_info["expires_on"] = Time.zone.at created_at + token_info["expires_in"]
      current_user = User.find_by id: Doorkeeper::AccessToken.where(refresh_token:
        params[:refresh_token]).select(:resource_owner_id)
      if current_user
        token_info[:uid] = current_user.uid
      end
      self.response_body = token_info.to_json
    end
  end
end
