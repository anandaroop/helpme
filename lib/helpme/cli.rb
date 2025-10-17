require "dry/cli"
require "ruby_llm"
require_relative "models"

RubyLLM.configure do |config|
  config.openai_api_key = ENV["HELPME_OPENAI_API_KEY"] || ENV["OPENAI_API_KEY"]
  config.anthropic_api_key = ENV["HELPME_ANTHROPIC_API_KEY"] || ENV["ANTHROPIC_API_KEY"]
  config.gemini_api_key = ENV["HELPME_GEMINI_API_KEY"] || ENV["GEMINI_API_KEY"]
end

module Helpme
  module CLI
    extend Dry::CLI::Registry

    register "list", Commands::ListCommand
    register "cost", Commands::CostCommand, aliases: ["price"]
    register "query", Commands::QueryCommand
  end
end
