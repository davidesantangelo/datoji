class EntriesController < BaseController
  # callbacks
  before_action :set_pack
  before_action :set_pack_entry, only: %i[show destroy update]

  # POST /packs/:id/entries.json
  def create
    @entry = @pack.entries.create!(data: entry_params)

    json_response_with_serializer(@entry, Serializer::ENTRY)
  end

  # POST /packs/:id/entries/bulk.json
  def bulk
    entries = bulk_entry_params.map do |entry|
      { data: entry,
        created_at: Time.current,
        updated_at: Time.current }
    end

    @pagy, @ids = pagy_array @pack.entries.insert_all!(entries, returning: %w[id]).rows.flatten

    json_success_response(@ids)
  end

  # GET /packs/:id/entries.json
  def index
    @pagy, @entries = pagy @pack.entries

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
    @pack = current_packs.find(params[:pack_id])
  end

  def set_pack_entry
    @entry = @pack.entries.find_by!(id: params[:id]) if @pack
  end

  def entry_params
    params.require(:entry).permit!
  end

  def bulk_entry_params
    params.require(:entries)
  end
end
