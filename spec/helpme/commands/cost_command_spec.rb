require "spec_helper"

RSpec.describe Helpme::Commands::CostCommand do
  subject(:command) { described_class.new }

  describe "#call" do
    it "outputs pricing information as JSON for specified model" do
      mock_pricing = double("pricing")
      allow(mock_pricing).to receive(:to_h).and_return({
        "input" => 0.25,
        "output" => 1.25
      })

      mock_model = double("model")
      allow(mock_model).to receive(:pricing).and_return(mock_pricing)

      mock_models = double("models")
      allow(mock_models).to receive(:find).with("claude-haiku-4-5-20251001").and_return(mock_model)
      allow(RubyLLM).to receive(:models).and_return(mock_models)

      expect { command.call(model: "claude-haiku-4-5-20251001") }.to output(<<~OUTPUT).to_stdout
        {
          "input": 0.25,
          "output": 1.25
        }
      OUTPUT
    end
  end
end
