local hl = function(self)
  return { fg = self.normal_hl.bg }
end

return {
  west = { provider = " ", hl = hl },
  east = { provider = " ", hl = hl },
}
