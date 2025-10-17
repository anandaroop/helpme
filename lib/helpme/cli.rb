require "dry/cli"

module Helpme
  module CLI
    extend Dry::CLI::Registry

    register "list", Commands::ListCommand
    register "cost", Commands::CostCommand
    register "query", Commands::QueryCommand, aliases: ["q"]
  end
end
