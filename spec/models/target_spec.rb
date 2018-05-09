require 'rails_helper'

RSpec.describe Target do
  describe '#title' do
    let(:target) { create(:target) }

    it 'returns the correct title' do
      expect(target.title).to eq(target.title)
    end
  end
end
