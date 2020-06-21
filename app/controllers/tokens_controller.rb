class TokensController < BaseController
  skip_before_action :require_authentication

  # POST /tokens
  def create
    @token = Token.create!

    json_response_with_serializer(@token, Serializer::TOKEN)
  end
end
