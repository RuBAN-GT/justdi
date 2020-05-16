module Justdi
  # Dependencies configuration
  module Injectable
    # Set dependency
    #
    # @param token [String, Symbol, Numeric, Class]
    def dependency(token, **opts)
      module_dependencies.set(token, opts)
    end

    # Get all dependencies
    #
    # @return [Hash]
    def dependencies
      module_dependencies.all
    end

    protected

    def module_dependencies
      @module_dependencies ||= Justdi::Store.new
    end
  end
end
