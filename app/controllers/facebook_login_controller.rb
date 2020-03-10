class FacebookLoginController < Devise::RegistrationsController
  before_filter :create_facebook_user, only: [:create]
  def create
    binding.pry
    super do |resource|
      binding.pry
      @resource = params
    end
  end

  private

  def create_facebook_user(params)
    if params[:provider] == 'facebook'
      @user = User.from_omniauth(params.require(:uid), params.require(:email), params.require(:provider))
      if @user.persisted?
        sign_in @user
        @token = @user.create_token
        @user.save
        @auth_params = {
          auth_token: @token.token,
          client_id:  @token.client,
          uid:        params[:uid],
          expiry:     @token.expiry,
        }
        render json: @auth_params
      else
        render json: { error: 'For helvede Mads' }
      end
      return
    end
  end
end