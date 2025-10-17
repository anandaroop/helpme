module Helpme
  class Response
    attr_reader :response

    def self.get(model:, query:)
      new(model:, query:, explain: nil).response
    end

    def self.explain(model:, explain:)
      new(model:, explain:, query: nil).response
    end

    def initialize(model:, query:, explain:)
      chat = begin
        RubyLLM.chat(model: model)
      rescue
        # silently refresh the model list, in case the requested model does exist
        original_level = RubyLLM.logger.level
        RubyLLM.logger.level = Logger::ERROR
        RubyLLM.models.refresh!
        RubyLLM.logger.level = original_level

        RubyLLM.chat(model: model)
      end

      chat.with_instructions(instructions).with_temperature(0.1)

      if query
        response = chat.ask query
        @response = response.content
      elsif explain
        response = chat.ask "Succinctly explain the command: #{explain}"
        @response = response.content
      end
    end

    def instructions
      <<~SYSTEM
        You are an expert user of the MacOS Unix command line.

        Your task is usually to take the user's request and produce the
        exact command line invocation that will accomplish the user's goal,
        including all necessary flags and arguments.

        For image related tasks, prefer using ImageMagick.

        For video related tasks, prefer using ffmpeg.

        For web related tasks, prefer using http (HTTPie)

        If you need more information from the user, state what's missing.

        NO YAPPING, no markdown, no codefence, no backticks, no fluff.

        Just the command.
      SYSTEM
    end
  end
end
