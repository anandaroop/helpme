require "dry/cli"

module Helpme
  module CLI
    class RootCommand < Dry::CLI::Command
      desc "A CLI for CLIs - use natural language to get help with commands"

      option :list, type: :boolean, desc: "List current known models"
      option :cost, type: :string, desc: "Print input/output token costs for a model"
      option :model, type: :string, desc: "Use specific model(s)"

      argument :query, type: :string, required: false, desc: "Natural language request"

      def call(query: nil, list: false, cost: nil, model: nil, **)
        if list
          puts "--list not yet implemented"
        elsif cost
          puts "--cost not yet implemented"
        elsif query
          Commands::QueryCommand.new(query: query, model: model).call
        else
          print_usage
        end
      end

      private

      def print_usage
        puts <<~USAGE
          helpme - A CLI for CLIs

          Use natural language to get help with commands and shell utilities.

          USAGE:
            helpme "some natural language request"

          OPTIONS:
            --list                  List current known models
            --cost MODEL            Print input/output token costs for a model
            --model MODEL(S)        Use specific model(s) (comma-separated)

          EXAMPLES:
            helpme "get out of the git detached head state"
            helpme "convert screencap.mov to 5fps gif, one-quarter size"
            helpme "prettify xml file sitemap-partners.xml"
            helpme --list
            helpme --cost claude-haiku-4-5-20251001
            helpme "some request" --model claude-haiku-4-5-20251001,gpt-5-mini
        USAGE
      end
    end
  end
end
