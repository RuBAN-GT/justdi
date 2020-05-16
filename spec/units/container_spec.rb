# frozen_string_literal: true

RSpec.describe Justdi::Container do
  def generate_container
    described_class.new
  end

  describe '#bind' do
    it 'register a static/constant value' do
      data = { token: Faker::Name.name, value: Faker::Number.digit }

      container = generate_container
      container.bind(data[:token]).use_value(data[:value])

      expect(container.get(data[:token])).to be data[:value]
    end

    it 'register a class object' do
      data = { token: Faker::Name.name, value: Class.new }

      container = generate_container
      container.bind(data[:token]).use_class(data[:value])

      expect(container.get(data[:token])).to be_instance_of data[:value]
    end

    it 'register a factory value' do
      data = { token: Faker::Name.name, value: Faker::Number.digit }

      container = generate_container
      container.bind(data[:token]).use_factory ->(_) { data[:value] }

      expect(container.get(data[:token])).to be data[:value]
    end
  end

  describe '#register' do
    it 'register a static/constant value' do
      data = { token: Faker::Name.name, value: Faker::Number.digit }

      container = generate_container
      container.register(data[:token], { type: Justdi::Definition::STATIC, value: data[:value] })

      expect(container.get(data[:token])).to be data[:value]
    end

    it 'register a class object' do
      data = { token: Faker::Name.name, value: Class.new }

      container = generate_container
      container.register(data[:token], { type: Justdi::Definition::CLASS, value: data[:value] })
      container.bind(data[:token]).use_class(data[:value])

      expect(container.get(data[:token])).to be_instance_of data[:value]
    end

    it 'register a factory value' do
      data = { token: Faker::Name.name, value: Faker::Number.digit }

      container = generate_container
      container.register(data[:token], {
        type: Justdi::Definition::FACTORY,
        value: ->(_) { data[:value] }
      })

      expect(container.get(data[:token])).to be data[:value]
    end
  end

  describe '#resolve' do
    context 'when dependencies are defined' do
      it 'resolves class dependencies' do
        class Orm; end
        class Repository
          extend Justdi::Injectable
          dependency :orm

          def initialize(_); end
        end

        container = generate_container.tap { |c| c.bind(:orm).use_class(Orm) }
        repo = container.resolve(Repository)

        expect(repo).to be_instance_of Repository
      end
    end

    context 'when dependencies are undefined' do
      it 'raises Justdi::NoDependencyError' do
        klass = Class.new do
          extend Justdi::Injectable
          dependency Faker

          def initialize(_); end
        end

        container = generate_container
        expect { container.resolve(klass) }.to raise_error(Justdi::NoDependencyError)
      end
    end
  end
end
