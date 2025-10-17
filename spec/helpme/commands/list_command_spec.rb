require "spec_helper"

RSpec.describe Helpme::Commands::ListCommand do
  subject(:command) { described_class.new }

  describe "#call" do
    it "outputs available models" do
      expect { command.call }.to output(/Available models/).to_stdout
    end
  end
end
