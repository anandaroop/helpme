require "spec_helper"

RSpec.describe Helpme::Commands::QueryCommand do
  describe "#call" do
    it "outputs hello message with query" do
      command = described_class.new(query: "test query", model: nil)
      expect { command.call }.to output("Hello! You asked: test query\n").to_stdout
    end
  end
end
