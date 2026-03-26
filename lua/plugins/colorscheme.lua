return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight")

      vim.opt.cursorline = true
      vim.opt.cursorlineopt = "number,line"

      vim.api.nvim_set_hl(0, "NormalNC", { bg = "#1f2335" })
    end,
  },
}
