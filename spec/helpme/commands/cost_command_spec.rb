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

    context "when model is not initially found" do
      it "refreshes models and retries" do
        mock_pricing = double("pricing")
        allow(mock_pricing).to receive(:to_h).and_return({
          "input" => 0.50,
          "output" => 2.00
        })

        mock_model = double("model")
        allow(mock_model).to receive(:pricing).and_return(mock_pricing)

        mock_models = double("models")
        call_count = 0
        allow(mock_models).to receive(:find).with("new-model-123") do
          call_count += 1
          if call_count == 1
            raise RubyLLM::ModelNotFoundError
          else
            mock_model
          end
        end
        allow(mock_models).to receive(:refresh!)
        allow(RubyLLM).to receive(:models).and_return(mock_models)

        expect { command.call(model: "new-model-123") }.to output(<<~OUTPUT).to_stdout
          {
            "input": 0.5,
            "output": 2.0
          }
        OUTPUT

        expect(mock_models).to have_received(:refresh!).once
        expect(mock_models).to have_received(:find).twice
      end
    end

    context "when model is not found even after refresh" do
      it "outputs the error message" do
        mock_models = double("models")
        allow(mock_models).to receive(:find).with("unknown-model")
          .and_raise(RubyLLM::ModelNotFoundError.new("Model not found"))
        allow(mock_models).to receive(:refresh!)
        allow(RubyLLM).to receive(:models).and_return(mock_models)

        expect { command.call(model: "unknown-model") }.to output(/Model not found/).to_stdout
      end
    end
  end
end
