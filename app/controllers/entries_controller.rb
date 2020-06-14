class EntriesController < BaseController
  # callbacks
  before_action :set_pack
  before_action :set_pack_entry, only: %i[show destroy update]

  # POST /packs/:id/entries.json
  def create
    @entry = @pack.entries.create!(data: entry_params)

    json_response_with_serializer(@entry, Serializer::ENTRY)
  end

  # GET /packs/:id/entries.json
  def index
    @pagy, @entries = pagy Entry.where(pack_id: params[:pack_id])

    @entries = @entries.reorder(created_at: params[:order].to_sym) if params[:order].present?

    json_response_with_serializer(@entries, Serializer::ENTRY)
  end

  # GET /packs/:id/entries/:id.json
  def show
    json_response_with_serializer(@entry, Serializer::ENTRY)
  end

  # PUT /packs/:id/entries/:id.json
  def update
    @entry.update!(data: entry_params)

    json_response_with_serializer(@entry, Serializer::ENTRY)
  end

  # DELETE /packs/:id/entries/:id.json
  def destroy
    @entry.destroy!

    head :no_content
  end

  private

  def set_pack
    @pack = Pack.find(params[:pack_id])
  end

  def set_pack_entry
    @entry = @pack.entries.find_by!(id: params[:id]) if @pack
  end

  def entry_params
    params.require(:entry).permit!
  end
end
