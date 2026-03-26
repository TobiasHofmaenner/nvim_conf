vim.g.mapleader = " "
vim.g.maplocalleader = " "
local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = ""
opt.showmode = false
opt.clipboard = "unnamedplus"
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.inccommand = "split"
opt.cursorline = true
opt.scrolloff = 8

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

opt.termguicolors = true
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  callback = function()
    vim.wo.winhighlight = "Normal:Normal,NormalNC:NormalNC"
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  callback = function()
    vim.wo.winhighlight = "Normal:NormalNC,NormalNC:NormalNC"
  end,
})
