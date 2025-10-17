module Helpme
  module Commands
    class QueryCommand < Dry::CLI::Command
      desc "Process a natural language request"

      argument :query, type: :string, required: true, desc: "Natural language request"
      option :model, type: :string, desc: "Use specific model(s) (comma-separated)"

      def call(query:, model: nil, **)
        puts "Hello! You asked: #{query}"
        puts "Using model(s): #{model}" if model
      end
    end
  end
end
