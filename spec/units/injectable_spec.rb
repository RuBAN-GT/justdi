# frozen_string_literal: true

RSpec.describe Justdi::Injectable do
  def generate_injectable_class
    Class.new { extend Justdi::Injectable }
  end

  describe '.dependency' do
    it 'puts information dependency token into class' do
      dep_name = Faker::Name.name
      klass    = generate_injectable_class.tap do |comp|
        comp.dependency dep_name
      end
      expect(klass.dependencies.key?(dep_name)).to be_truthy
    end

    it 'saves additional information about dependency into class' do
      dep_name = Faker::Name.name, Faker::Types.rb_hash
      dep_meta = Faker::Types.rb_hash
      klass    = generate_injectable_class.tap do |comp|
        comp.dependency dep_name, **dep_meta
      end
      expect(klass.dependencies[dep_name]).to eq dep_meta
    end
  end
end
