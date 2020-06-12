class SearchController < BaseController
  # callbacks
  before_action :check_params
  before_action :set_pack

  def index
    @pagy, @entries = pagy @pack.entries.web_search(data: permitted_params[:q])

    json_response_with_serializer(@entries, Serializer::ENTRY)
  rescue StandardError => e
    Rails.logger.error(e)
    json_error_response('SearchEntriesError', e.message, 500)
  end

  private

  def permitted_params
    params.permit(:q)
  end

  def set_pack
    @pack = current_packs.find(params[:pack_id])
  end

  def check_params
    return if permitted_params[:q].present?

    json_error_response('Validation Failed', 'missing q param', :unprocessable_entity)
  end
end
