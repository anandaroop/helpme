require "spec_helper"

RSpec.describe Helpme::CLI::RootCommand do
  subject(:command) { described_class.new }

  describe "#call" do
    context "when called with no arguments" do
      it "prints the usage message" do
        expect { command.call }.to output(/helpme - A CLI for CLIs/).to_stdout
      end

      it "includes usage examples" do
        expect { command.call }.to output(/EXAMPLES:/).to_stdout
      end
    end

    context "when called with --list" do
      it "shows not yet implemented message" do
        expect { command.call(list: true) }.to output("--list not yet implemented\n").to_stdout
      end
    end

    context "when called with --cost" do
      it "shows not yet implemented message" do
        expect { command.call(cost: "claude-haiku-4-5-20251001") }.to output("--cost not yet implemented\n").to_stdout
      end
    end

    context "when called with a query" do
      it "shows hello message with query" do
        expect { command.call(query: "some query") }.to output("Hello! You asked: some query\n").to_stdout
      end
    end
  end
end
