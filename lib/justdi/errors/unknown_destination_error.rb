# frozen_string_literal: true

module Justdi
  class UnknownDestinationError < StandardError
    def initialize(destination)
      super "Unknown destination: #{destination}"
    end
  end
end
