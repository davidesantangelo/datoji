require 'pagy/extras/headers'
require 'pagy/extras/array'

class BaseController < ApplicationController
  include Response
  include ExceptionHandler
  include Serializer
  include Pagy::Backend
  include ::ActionController::Cookies
  include ActionController::HttpAuthentication::Token::ControllerMethods

  Pagy::VARS[:headers] = { page: 'Current-Page', items: 'Per-Page', pages: false, count: 'Total' }

  def render(*args, &block)
    pagy_headers_merge(@pagy) if @pagy
    super
  end

  # CSRF protection is turned on with the protect_from_forgery method
  protect_from_forgery unless: -> { request.format.json? }

  # callbacks
  before_action :require_authentication

  def current_token
    @current_token ||= authenticate_token
  end

  def current_packs
    current_token.packs
  end

  def require_authentication
    authenticate_token || render_unauthorized('the access token provided is invalid or expired')
  end

  private

  def render_unauthorized(message)
    json_error_response(Response::ACCESS_TOKEN_EXCEPTION, message, :unauthorized)
  end

  def check_token_authorization
    json_error_response('Unauthorized Token', 'your token is not qualified to perform this action.', :unauthorized)
  end

  def authenticate_token
    authenticate_or_request_with_http_token do |token, _|
      if (api_token = Token.active.find_by(key: token))
        # Compare the tokens in a time-constant manner, to mitigate timing attacks.
        ActiveSupport::SecurityUtils.secure_compare(
          ::Digest::SHA256.hexdigest(token),
          ::Digest::SHA256.hexdigest(api_token.key)
        )
        api_token
      end
    end
  end
end
