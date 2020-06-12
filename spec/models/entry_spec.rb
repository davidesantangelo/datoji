require 'rails_helper'

RSpec.describe Entry, type: :model do
  let(:pack) { Pack.create! }
  let(:entry) { Entry.new }

  it { should belong_to(:pack) }

  describe 'validations' do
    it { should validate_presence_of(:data) }
  end

  it 'is valid with valid attributes' do
    expect(FactoryBot.create(:entry)).to be_valid
  end
end
