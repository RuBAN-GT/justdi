# frozen_string_literal: true

RSpec.describe Justdi::Definition do
  describe '#resolve' do
    let(:resolved_value) { rand(1..100) }

    it 'puts self as a resolving block argument' do
      definition = described_class.new(value: nil)
      definition.resolve { |input| expect(input).to be definition }
    end

    it 'generates resolved value using Proc' do
      definition = described_class.new(value: nil)
      result     = definition.resolve { |_| resolved_value }
      expect(result).to be resolved_value
    end

    it 'saves resolved result with #value' do
      definition = described_class.new(value: nil)

      expect(definition.value).to be_nil
      result = definition.resolve { |_| resolved_value }
      expect(result).to be resolved_value
      expect(definition.value).to be resolved_value
    end

    it 'uses resolved value if it was already defined' do
      counter  = double
      resolver = ->(_) { counter.call }
      expect(counter).to receive(:call).once.and_return(resolved_value)

      definition = described_class.new(value: nil)
      value      = definition.resolve(&resolver)
      rand(1..10).times { expect(definition.resolve(&resolver)).to be value }
    end
  end
end
