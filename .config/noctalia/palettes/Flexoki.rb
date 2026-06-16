# frozen_string_literal: true

require "json"
require "yaml"

colorscheme = JSON.pretty_generate(YAML.load_file("Flexoki.yaml"))

File.open("Flexoki.json", "w") { |it| it << colorscheme }
