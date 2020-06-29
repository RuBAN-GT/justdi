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

    it 'imports definition store with overwritting of existing values' do
      container = described_class.new.tap do |c|
        c.register(:example).use_value(101)
      end
      def_store = Justdi::DefinitionStore.new.tap do |store|
        store.register(:example).use_value(static_value)
      end

      container.import_store(def_store, overwrite: true)
      expect(container.get(:example)).to be(static_value)
    end

    it 'imports definition store with preserving of existing values' do
      container = described_class.new.tap do |c|
        c.register(:example).use_value(101)
      end
      def_store = Justdi::DefinitionStore.new.tap do |store|
        store.register(:example).use_value(static_value)
      end

      container.import_store(def_store, overwrite: false)
      expect(container.get(:example)).to be(101)
    end
  end
end
