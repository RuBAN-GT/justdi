# frozen_string_literal: true

RSpec.describe Justdi::FactoryResolver do
  let(:container) { Justdi::Container.new }

  describe '.call' do
    it 'invokes a factory passing container as an argument' do
      factory = ->(input) { expect(input).to be container }
      described_class.call(factory, container)
    end

    it 'returns factory results' do
      factory_res = rand(1..100)
      factory_fun = ->(_) { factory_res }

      expect(described_class.call(factory_fun, container)).to be factory_res
    end
  end
end
