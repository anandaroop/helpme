# helpme

A CLI for CLIs

Use natural language to get help with commands and shell utilities from multiple LLMs at once:

<!--
![examples-heic](https://github.com/user-attachments/assets/6017455b-ab8a-409a-90cb-277acc0c7854)
-->

![examples-heic4s](https://github.com/user-attachments/assets/04060f25-2c5b-4c7c-a3cf-1f31f964c6da)

## Examples

```sh
helpme "get out of the git detached head state"

helpme "convert screencap.mov to 5fps gif, one-quarter size"

helpme "prettify xml file sitemap-partners.xml"

helpme "extract geolocation info from IMG_9967.HEIC without exiftool"
```

## Usage

```sh
# view help
helpme

# basic usage
helpme "some natural language request"

# list current known models
helpme list

# print input/output token costs for a model
helpme cost claude-haiku-4-5-20251001

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

## API Keys

You will need API keys in your ENV for all the model providers `helpme` uses.

See [.env.example](.env.example) for the default ENV var names.

(`helpme` will also [fall back to more generically named API keys](lib/helpme/cli.rb) if they are in your ENV already.)

## Modifying

`helpme` can be customized as follows:

- Update the system prompt in [lib/helpme/response.rb](lib/helpme/response.rb) to tailor `helpme` to your setup.
  - For example I nudge it to use `imagemagick` for images, `ffmpeg` for videos; `http` instead of `curl`, etc.

- Update the list of models in [lib/helpme/models.rb](lib/helpme/models.rb) to determine which models will be used by default. (See below for refreshing model list)

- Update the list of providers in [lib/helpme/commands/list_command.rb](lib/helpme/commands/list_command.rb) to determine which additional models can be listed or costed. (If you add providers, you'll likely need to account for API key configuration too in [lib/helpme/cli.rb](lib/helpme/cli.rb))

## Refreshing model list

See: https://rubyllm.com/models/#refreshing-the-registry

```rb
> bundle console

# update model list in memory
RubyLLM.models.refresh!

# persist updated list
RubyLLM.models.save_to_json

# view model ids
RubyLLM::models.map(&:id)

# filter ids by family
RubyLLM::models.map(&:id).select{ |id| id =~ /sonnet/i}
```
