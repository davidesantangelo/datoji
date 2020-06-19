class PacksController < BaseController
  before_action :set_pack, only: %i[show clear destroy]

  # POST /packs
  def create
    @pack = current_packs.create!

    json_response_with_serializer(@pack, Serializer::PACK)
  end

  # POST /packs/:id/clear
  def clear
    @pack.entries.delete_all

    json_response_with_serializer(@pack, Serializer::PACK)
  end

  # GET /packs
  def index
    @pagy, packs = pagy current_packs

    json_response_with_serializer(packs, Serializer::PACK)
  end

  # GET /packs/:id
  def show
    json_response_with_serializer(@pack, Serializer::PACK)
  end

  # DELETE /packs/:id
  def destroy
    @pack.destroy!

    head :no_content
  end

  private

  def set_pack
    @pack = current_packs.find(params[:id])
  end

  def pack_params
    params.require(:pack).permit(:token, :active, :expired)
  end
end
