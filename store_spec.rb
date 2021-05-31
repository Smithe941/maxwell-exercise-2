# frozen_string_literal: true

require 'rspec'
load 'store.rb'

RSpec.describe Store do
  subject do
    store = Store.new
    store.calculate(order)
  end

  describe 'calculate' do
    let(:valid_order) { [1, 2, 2, 3, 1, 1, 4, 2] }
    let(:invalid_order) { [6, 5, 12] }
    let(:expected_hash) do
      {
        items: [
          { name: 'milk', price: 8.97, quantity: 3 },
          { name: 'bread', price: 6.0, quantity: 3 },
          { name: 'banana', price: 0.99, quantity: 1 },
          { name: 'apple', price: 0.89, quantity: 1 }
        ],
        sum: 16.85,
        discount: 3.45
      }
    end

    context 'with valid order' do
      let(:order) { valid_order }

      it { is_expected.to eq expected_hash }
    end

    context 'with valid and invalid order' do
      let(:order) { valid_order + invalid_order }

      it { is_expected.to eq expected_hash }
    end

    context 'with invalid order' do
      let(:order) { invalid_order }
      let(:expected_hash) { { items: [], discount: 0, sum: 0 } }

      it { is_expected.to eq expected_hash }
    end
  end
end