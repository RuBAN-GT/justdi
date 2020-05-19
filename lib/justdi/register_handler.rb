# frozen_string_literal: true

module Justdi
  # Utilitary handler registering value definitions
  class RegisterHandler
    attr_reader :callback

    def initialize(&block)
      @callback = block
    end

    # Push class definition into container
    #
    # @param klass [Class]
    def use_class(klass)
      callback.call(
        Definition.new(type: Definition::CLASS, value: klass)
      )
    end

    # Push a static definition into container
    #
    # @param value [*]
    def use_value(value)
      callback.call(
        Definition.new(type: Definition::STATIC, value: value)
      )
    end

    # Push a factory definition into container
    #
    # @param factory [Proc]
    # @param block [Proc]
    def use_factory(factory = nil, &block)
      factory = block if block_given?
      callback.call(
        Definition.new(type: Definition::FACTORY, value: factory)
      )
    end
  end
end
