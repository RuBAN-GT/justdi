# frozen_string_literal: true

RSpec.describe Justdi::Container do
  let(:static_value) { rand(1..100) }

  describe '.new' do
    it 'creates a new empty container' do
      container = described_class.new

      expect(container).to be_instance_of Justdi::Container
      expect(container.empty?).to be_truthy
    end
  end
end
