local api = vim.api

---@class Config.Colors
local M = {
  highlights = {
    RainbowRed = { fg = "#E06C75" },
    RainbowYellow = { fg = "#E5C07B" },
    RainbowBlue = { fg = "#61AFEF" },
    RainbowOrange = { fg = "#D19A66" },
    RainbowGreen = { fg = "#98C379" },
    RainbowViolet = { fg = "#C678DD" },
    RainbowCyan = { fg = "#56B6C2" },
  },
}

function M.setup()
  for k, v in pairs(M.highlights) do
    api.nvim_set_hl(0, k, v)
  end
end

return M
