# frozen_string_literal: true

RSpec.describe Justdi::Container do
  def generate_container
    described_class.new
  end

  let(:static_value) { rand(1..100) }

  describe '#merge' do
    it 'merges two containers' do
      container_a = generate_container
      container_b = generate_container.tap do |c|
        c.register(:b).use_value(static_value)
      end

      container_a.merge(container_b)
      expect(container_a.get(:b)).to be static_value
    end

    it 'overwrites previous values' do
      container_a = generate_container.tap do |c|
        c.register(:a).use_value(42)
      end
      container_b = generate_container.tap do |c|
        c.register(:a).use_value(static_value)
      end

      container_a.merge(container_b)
      expect(container_a.get(:a)).to be static_value
    end
  end
end
