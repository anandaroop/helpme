# Development Guidelines

## Tech stack

- **Language**: Ruby 3.4.5 (managed via mise-en-place)
- **Package**: Rubygem
- **Framework**: dry-cli
- **Linting**: StandardRB
- **Testing**: Rspec
- **Task runner**: Rake
- **LLM**: RubyLLM (see https://rubyllm.com)

## User interface guidelines

- Use **rainbow** gem judiciously for colored output
- Use **tty-spinner** gem for terminal feedback

## Conventions

Always follow these

- Use TDD
- Lint and test before committing
- Use conventional-commits format

## Commands

- Lint and test: `bundle exec rake`
- Lint: `bundle exec rake lint`
- Test: `bundle exec rake test`
