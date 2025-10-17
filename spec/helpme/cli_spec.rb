require "spec_helper"

RSpec.describe Helpme::CLI do
  describe "module" do
    it "extends Dry::CLI::Registry" do
      expect(described_class.singleton_class.ancestors).to include(Dry::CLI::Registry)
    end
  end
end
