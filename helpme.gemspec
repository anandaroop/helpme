Gem::Specification.new do |spec|
  spec.name = "helpme"
  spec.version = "0.1.0"
  spec.authors = ["Roop"]
  spec.summary = "A CLI for CLIs"
  spec.description = "Use natural language to get help with commands and shell utilities"
  spec.homepage = "https://github.com/anandaroop/helpme"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.4.0"

  spec.files = Dir["lib/**/*", "bin/*", "README.md"]
  spec.bindir = "bin"
  spec.executables = ["helpme"]
  spec.require_paths = ["lib"]

  spec.add_dependency "dry-cli", "~> 1.0"
  spec.add_dependency "tty-spinner", "~> 0.9"
  spec.add_dependency "rainbow", "~> 3.1"
  spec.add_dependency "ruby_llm", "~> 1.8"
end
