# frozen_string_literal: true

if defined? Reline::Face
  Reline::Face.config(:completion_dialog) do |conf|
    conf.define :default,   foreground: :black, background: :bright_cyan
    conf.define :enhanced,  foreground: :bright_white, background: :blue, style: :bold
    conf.define :scrollbar, foreground: :gray, background: :black
  end
end
