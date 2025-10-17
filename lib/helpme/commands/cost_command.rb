module Helpme
  module Commands
    class CostCommand < Dry::CLI::Command
      desc "Print input/output token costs for a model"

      argument :model, type: :string, required: true, desc: "Model name"

      def call(model:, **)
        print_cost(model)
      rescue RubyLLM::ModelNotFoundError
        begin
          RubyLLM.models.refresh!
          print_cost(model)
        rescue => e
          puts e
        end
      end

      def print_cost(model)
        puts JSON.pretty_generate(RubyLLM.models.find(model).pricing.to_h)
      end
    end
  end
end
