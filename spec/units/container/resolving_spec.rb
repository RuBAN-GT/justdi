# frozen_string_literal: true

RSpec.describe Justdi::Container do
  describe '#resolve' do
    let(:class_input) { Class.new }
    it 'calls .class_value method of configured/default resolver' do
      resolver   = spy
      container  = Class.new(Justdi::Container).tap do |klass|
        klass.resolver = resolver
      end.new

      container.resolve(class_input)
      expect(resolver).to have_received(:class_value).with(class_input, container)
    end
  end
end
