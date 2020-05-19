# frozen_string_literal: true

RSpec.describe Justdi::Container do
  def generate_container
    described_class.new
  end

  describe '#set' do
    it 'register a static/constant value' do
      data      = generate_static_data
      container = generate_container
      container.set(data[:token], type: Justdi::Definition::STATIC, value: data[:value])

      expect(container.get(data[:token])).to be data[:value]
    end

    it 'register a class object' do
      data      = generate_class_data
      container = generate_container
      container.set(data[:token], type: Justdi::Definition::CLASS, value: data[:value])

      expect(container.get(data[:token])).to be_instance_of data[:value]
    end

    it 'register a factory value' do
      data      = generate_static_data
      container = generate_container
      container.set(
        data[:token],
        type: Justdi::Definition::FACTORY,
        value: ->(_) { data[:value] }
      )
      expect(container.get(data[:token])).to be data[:value]
    end
  end
end
