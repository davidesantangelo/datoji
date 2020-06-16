class TokensController < BaseController
  skip_before_action :require_authentication

  # POST /tokens
  def create
    @token = Token.create!

    json_response_with_serializer(@token, Serializer::TOKEN)
  end

  # GET /generate
  def generate
    respond_to do |format|
      format.html do
        @token = Token.create!
      end
    end
  end
end
