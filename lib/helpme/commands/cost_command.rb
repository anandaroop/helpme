module Helpme
  module Commands
    class CostCommand < Dry::CLI::Command
      desc "Print input/output token costs for a model"

      argument :model, type: :string, required: true, desc: "Model name"

      def call(model:, **)
        puts "Token costs TKTK"
      end
    end
  end
end
