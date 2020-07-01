# frozen_string_literal: true

RSpec.describe Justdi::Container do
  describe '#resolve' do
    let(:class_input) { Class.new }
    it 'calls .class_value method of configured resolver' do
      custom_resolver  = spy
      custom_container = Class.new(Justdi::Container) do
        use_resolver custom_resolver
      end

      container = custom_container.new
      container.resolve(class_input)
      expect(custom_resolver).to have_received(:class_value).with(
        class_input,
        container
      )
    end
  end
end
