# frozen_string_literal: true

RSpec.describe Justdi::Definition do
  describe '#resolve' do
    it 'puts self to resolving block' do
      definition = described_class.new(
        type: Justdi::Definition::STATIC, value: nil
      )
      definition.resolve do |input|
        expect(input).to be definition
      end
    end

    it 'generates resolved value using Proc' do
      resolved_value = Faker::Number.digit
      definition = described_class.new(
        type: Justdi::Definition::STATIC, value: nil
      )

      result = definition.resolve { |_| resolved_value }
      expect(result).to be resolved_value
    end

    it 'saves resolved result with #value' do
      resolved_value = Class.new
      definition = described_class.new(
        type: Justdi::Definition::CLASS, value: nil
      )

      expect(definition.value).to be_nil

      result = definition.resolve { |_| resolved_value }
      expect(result).to be resolved_value
      expect(definition.value).to be resolved_value
    end

    it 'uses resolved value if it was already defined' do
      definition = described_class.new(
        type: Justdi::Definition::STATIC, value: nil
      )

      first_res  = definition.resolve { |_| Faker::Number.digit }
      second_res = definition.resolve { |_| Faker::Number.digit }
      expect(second_res).to be first_res
    end
  end
end
