vim9script

g:ale_virtualtext_cursor = "disabled"

# https://github.com/dense-analysis/ale#5i-how-do-i-disable-particular-linters
g:ale_linters = {
  "ruby": ["ruby", "rubocop", "solargraph"]
}

g:ale_echo_msg_format = "(%linter%) %code: %%s"
