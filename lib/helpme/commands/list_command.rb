module Helpme
  module Commands
    class ListCommand < Dry::CLI::Command
      desc "List current known models"

      def call(**)
        puts "Available models TKTK"
      end
    end
  end
end
