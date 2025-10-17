# helpme

A CLI for CLIs.

Use natural language to get help with commands and shell utilities.

## Examples

```sh
helpme "get out of the git detached head state"

helpme "convert screencap.mov to 5fps gif, one-quarter size"

helpme "prettify xml file sitemap-partners.xml"
```

## Usage

```sh
# view help
helpme

# basic usage
helpme "some natural language request"

# list current known models
helpme --list

# print input/output token costs for a model
helpme --cost claude-haiku-4-5-20251001

# use specific model(s)
helpme "some request" --model claude-haiku-4-5-20251001,gpt-5-mini
```

## Installation

This project is distributed as a gem which can be installed from source.

```sh
# download and build
git clone git@github.com:anandaroop/helpme.git
cd helpme
bundle install
```

```sh
# install locally
bundle exec rake install
```

## Modifying

Update the system prompt to tailor `helpme` to your setup.

For example I nudge it to use `imagemagick` for images, `ffmpeg` for videos; `gifski` for animated gifs, etc.

## Development

- **Language**: Ruby 3.4.5 (managed via mise-en-place)
- **Package**: Rubygem
- **Framework**: dry-cli
- **Linting**: StandardRB
- **Testing**: Rspec
- **Task runner**: Rake
- **Conventions**
  - Use TDD
  - Lint and test before committing
  - Use conventional-commits format
