# frozen_string_literal: true

RSpec.describe Justdi::ClassResolver do
  let(:container) { Justdi::Container.new }

  describe '.call' do
    it 'builds common (non-injectable) classes' do
      klass  = Class.new
      result = described_class.call(klass, container)

      expect(result).to be_instance_of klass
    end
  end
end
