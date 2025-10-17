require "spec_helper"

RSpec.describe Helpme::Commands::ListCommand do
  subject(:command) { described_class.new }

  describe "#call" do
    context "when --all is false" do
      it "outputs current known models" do
        allow(Helpme::Models).to receive(:current).and_return([
          "claude-haiku-4-5-20251001",
          "gpt-4.1-2025-04-14"
        ])

        expect { command.call(all: false) }.to output(<<~OUTPUT).to_stdout
          claude-haiku-4-5-20251001
          gpt-4.1-2025-04-14
        OUTPUT
      end
    end

    context "when --all is true" do
      let(:mock_model_list) do
        [
          double(provider: "anthropic", id: "claude-3-5-sonnet-20241022"),
          double(provider: "openai", id: "gpt-4o-mini"),
          double(provider: "gemini", id: "gemini-2.5-flash"),
          double(provider: "other", id: "other-model")
        ]
      end

      let(:mock_models) do
        double("models").tap do |models|
          allow(models).to receive(:refresh!)
          allow(models).to receive(:select).and_yield(mock_model_list[0]).and_yield(mock_model_list[1]).and_yield(mock_model_list[2]).and_yield(mock_model_list[3]).and_return(mock_model_list.first(3))
        end
      end

      it "refreshes and outputs all available models from specified providers" do
        allow(RubyLLM).to receive(:models).and_return(mock_models)

        expect(mock_models).to receive(:refresh!)
        expect { command.call(all: true) }.to output(<<~OUTPUT).to_stdout
          claude-3-5-sonnet-20241022
          gpt-4o-mini
          gemini-2.5-flash
        OUTPUT
      end
    end
  end
end
