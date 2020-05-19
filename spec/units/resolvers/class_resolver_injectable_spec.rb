# frozen_string_literal: true

RSpec.describe Justdi::ClassResolver do
  def generate_container
    Justdi::Container.new
  end

  describe '.call' do
    context 'when dependencies are defined' do
      it 'puts resolved dependency into initializer as default behaviour' do
        class Orm; end
        class Repository
          extend Justdi::Injectable
          dependency :orm
        end

        expect(Repository).to receive(:new) { |orm:| expect(orm).to be_instance_of(Orm) }
        container = generate_container.tap { |c| c.register(:orm).use_class(Orm) }
        described_class.call(Repository, container)
      end

      it 'puts resolved dependency into initializer' do
        class Orm; end
        class Repository
          extend Justdi::Injectable
          dependency :orm, destination: :initializer
        end

        expect(Repository).to receive(:new) { |orm:| expect(orm).to be_instance_of(Orm) }
        container = generate_container.tap { |c| c.register(:orm).use_class(Orm) }
        described_class.call(Repository, container)
      end

      it 'puts resolved dependency as a class method with :class_method destination without affecting an input' do
        class Orm; end
        class Repository
          extend Justdi::Injectable
          dependency :orm, destination: :class_method
        end

        container  = generate_container.tap { |c| c.register(:orm).use_class(Orm) }
        repository = described_class.call(Repository, container)

        expect(repository).to be_is_a(Repository)
        expect(repository).not_to be_instance_of(Repository)
        expect(repository.class.orm).to be_instance_of(Orm)
        expect { Repository.orm }.to raise_error(NoMethodError)
      end

      it 'puts resolved dependency as an instance method with :method destination without affecting an input' do
        class Orm; end
        class Repository
          extend Justdi::Injectable
          dependency :orm, destination: :method
        end

        container  = generate_container.tap { |c| c.register(:orm).use_class(Orm) }
        repository = described_class.call(Repository, container)

        expect(repository).to be_is_a(Repository)
        expect(repository).not_to be_instance_of(Repository)
        expect(repository.orm).to be_instance_of(Orm)
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
