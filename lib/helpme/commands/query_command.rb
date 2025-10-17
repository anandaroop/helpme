require_relative "../response"
require "tty-spinner"
require "rainbow"
require "rainbow/refinement"
using Rainbow

module Helpme
  module Commands
    class QueryCommand < Dry::CLI::Command
      desc "Process a natural language request (default subcommand)"

      argument :query, type: :string, required: true, desc: "Natural language request"
      option :model, type: :string, desc: "Use specific model(s) (comma-separated)"

      def call(query:, model: nil, **)
        models = if model
          model.split(",")
        else
          Helpme::Models.current
        end

        results = {}
        spinners = TTY::Spinner::Multi.new("[:spinner] #{"helpme".faint} #{query}")
        max_model_name_length = models.map(&:length).max

        threads = models.map do |model_id|
          Thread.new do
            spinner = spinners.register("[:spinner] #{"asking".faint} :model", format: :dots)
            spinner.update(model: model_id.faint)
            spinner.auto_spin
            response = Helpme::Response.get(model: model_id, query: query)
            spinner.update(model: model_id)
            spinner.success
            results[model_id] = response
          end
        end

        threads.each(&:join)
        puts

        results.each_with_index do |result, index|
          model, response = result
          puts "[%s] %-#{max_model_name_length}s %s" % [index.to_s.bright, model, response.green.bright]
        end

        print "\nChoose command number (or Enter to quit): "
        user_response = $stdin.gets

        # maybe explain the command, and wait

        if user_response =~ /^e(\d+)/i
          selected_index = $1.to_i
          model, selected_command = results.to_a[selected_index]

          puts Rainbow("Getting explanation…").darkgray
          response = Helpme::Response.explain(model: model, explain: selected_command)
          puts Rainbow(response).blue
          user_response = $stdin.gets
        end

        # maybe run the command

        if user_response =~ /^(\d+)/i
          selected_index = $1.to_i
          model, selected_command = results.to_a[selected_index]
          puts Rainbow("Running [#{selected_index}] #{selected_command}").green.bright
          system selected_command
        end
      end
    end
  end
end
