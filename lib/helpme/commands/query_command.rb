module Helpme
  module Commands
    class QueryCommand
      def initialize(query:, model: nil)
        @query = query
        @model = model
      end

      def call
        puts "Hello! You asked: #{@query}"
      end
    end
  end
end
