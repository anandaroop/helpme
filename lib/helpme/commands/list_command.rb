module Helpme
  module Commands
    class ListCommand < Dry::CLI::Command
      desc "List current known models"

      option :all, type: :boolean, default: false, desc: "List all models"

      def call(all:, **)
        if all
          RubyLLM.models.refresh!
          puts RubyLLM.models.select { |m| ["anthropic", "openai", "gemini"].include? m.provider }.map(&:id).select { |m| m =~ /^(claude|gpt|gemini)/ }
        else
          puts Helpme::Models.current
        end
      end
    end
  end
end
