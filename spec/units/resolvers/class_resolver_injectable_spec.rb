# frozen_string_literal: true

RSpec.describe Justdi::ClassResolver do
  def generate_container
    Justdi::Container.new
  end

  describe '.call' do
    context 'when dependencies are defined' do
      it 'resolves class dependencies' do
        class Orm; end
        class Repository
          extend Justdi::Injectable
          dependency :orm

          def initialize(_); end
        end

        container = generate_container.tap { |c| c.bind(:orm).use_class(Orm) }
        repo      = described_class.call(Repository, container)

        expect(repo).to be_instance_of Repository
      end
    end

    context 'when dependencies are undefined' do
      it 'raises Justdi::NoDependencyError' do
        klass = Class.new do
          extend Justdi::Injectable
          dependency :orm

          def initialize(_); end
        end

        expect { described_class.call(klass, generate_container) }.to(
          raise_error(Justdi::NoDependencyError)
        )
      end
    end
  end
end
