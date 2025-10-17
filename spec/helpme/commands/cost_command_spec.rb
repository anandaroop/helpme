require "spec_helper"

RSpec.describe Helpme::Commands::CostCommand do
  subject(:command) { described_class.new }

  describe "#call" do
    it "outputs token costs for specified model" do
      expect { command.call(model: "claude-haiku") }.to output(/Token costs/).to_stdout
    end
  end
end
