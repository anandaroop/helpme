require "spec_helper"

RSpec.describe Helpme::Commands::QueryCommand do
  subject(:command) { described_class.new }

  describe "#call" do
    it "outputs hello message with query" do
      expect { command.call(query: "test query") }.to output("Hello! You asked: test query\n").to_stdout
    end

    it "outputs model when provided" do
      expect { command.call(query: "test query", model: "claude-haiku") }.to output(/Hello! You asked: test query.*Using model\(s\): claude-haiku/m).to_stdout
    end
  end
end
