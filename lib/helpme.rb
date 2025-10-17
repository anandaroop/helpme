require "dry/cli"

module Helpme
  VERSION = "0.1.0"
end

require_relative "helpme/commands/query_command"
require_relative "helpme/cli"
