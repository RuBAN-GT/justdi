# frozen_string_literal: true

module Justdi
  module DataHelper
    def generate_static_data
      { token: Faker::Name.name, value: Faker::Number.digit }
    end

    def generate_class_data
      { token: Faker::Name.name, value: Class.new }
    end
  end
end
