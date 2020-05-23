# frozen_string_literal: true

RSpec.describe Justdi::Container do
  let(:static_value) { rand(1..100) }

  describe '#import_store' do
    it 'imports definition store' do
      container = described_class.new
      def_store = Justdi::DefinitionStore.new.tap do |store|
        store.register(:example).use_value(static_value)
      end

      container.import_store(def_store)
      expect(container.get(:example)).to be(static_value)
    end
  end
end
