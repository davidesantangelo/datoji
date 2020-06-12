# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pack, type: :model do
  let(:pack) { Pack.new }

  it { should have_many(:entries) }
end
