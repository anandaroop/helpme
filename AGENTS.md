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

- When asked to implement a feature from scratch-
  - make sure you have enough info to build it
  - use test-driven development (TDD) to drive out the feature
  - use mocks to
    - make tests resilient to configuration changes
    - avoid network access
- Lint and test before committing
- Use conventional-commits format

## Commands

- Lint and test: `bundle exec rake`
- Lint: `bundle exec rake lint`
- Lint and fix: `bundle exec rake lint:fix`
- Test: `bundle exec rake test`
- Test verbose: `bundle exec rake test:doc`
