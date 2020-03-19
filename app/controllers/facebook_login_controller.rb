class FacebookLoginController < DeviseTokenAuth::RegistrationsController
  def create
    if params['provider'] == 'facebook'
      user = User.from_omniauth(params.require(:uid), params.require(:email), params.require(:provider))
      if user.persisted?
        sign_in user
        token = user.create_token
        user.save
        auth_params = {
          auth_token: token.token,
          client_id: token.client,
          uid: params[:uid],
          expiry: token.expiry
        }

        render json: auth_params
      end
    else
      super
    end
  end
end