# frozen_string_literal: true

require 'bundler/setup'
require 'justdi'

require_relative './helpers/data_helper'
Bundler.require(:default, :test)

RSpec.configure do |config|
  config.include Justdi::DataHelper

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
