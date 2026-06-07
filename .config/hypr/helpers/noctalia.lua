local M = {
  dsp = {
    restart = hl.dsp.exec_cmd("qs -c noctalia-shell kill; sleep 1; qs -c noctalia-shell"),
  },
}

function M.restart()
  hl.dispatch(M.dsp.restart)
end

return M
