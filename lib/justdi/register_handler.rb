# frozen_string_literal: true

module Justdi
  # Handler of registered values
  class RegisterHandler
    attr_reader :callback

    def initialize(&block)
      @callback = block
    end

    def use_class(value)
      callback.call(
        Definition.new({ type: Definition::CLASS, value: value })
      )
    end

    def use_value(value)
      callback.call(
        Definition.new({ type: Definition::STATIC, value: value })
      )
    end

    def use_factory(factory)
      callback.call(
        Definition.new({ type: Definition::FACTORY, value: factory })
      )
    end
  end
end
