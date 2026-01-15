-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true
vim.wo.cursorline = true
-- Display tabs and trailing spaces
vim.opt.list = true
vim.opt.listchars = {
  lead = "·", -- 空格显示为点
  tab = "→ ", -- Tab 显示为箭头
  trail = " ", -- 行尾空格显示为点
  -- extends = "…", -- 只有一行且超出屏幕时显示
  -- precedes = "…", -- 同上
  -- nbsp = "␣", -- 不换行空格
}
-- 设置点的颜色 (建议放在 colorscheme 设置之后，或者用 autocmd 强制覆盖)
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- 浅灰色，既能看见又不会太抢眼
    vim.api.nvim_set_hl(0, "Whitespace", { fg = "#444444" })
    -- 如果你也想改 Tab 箭头的颜色，有些主题用的是 NonText
    vim.api.nvim_set_hl(0, "NonText", { fg = "#444444" })
  end,
})
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 10
vim.opt.startofline = false

vim.opt.conceallevel = 2

vim.o.signcolumn = "yes:1"

vim.wo.wrap = false

-- Enables project-local `.nvim.lua` configuration file
vim.o.exrc = true

-- Tab related options
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.splitbelow = true
vim.opt.splitright = true

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.shell = "zsh"

vim.o.winborder = "rounded"
vim.opt.guicursor =
  "n-v-c-sm:block-blinkwait700-blinkoff400-blinkon250,i-ci-ve:ver25-blinkwait700-blinkoff400-blinkon250,r-cr-o:hor20-blinkwait700-blinkoff400-blinkon250"
-- 禁用终端粗体，让 Neovim 字体更细
vim.g.terminal_bold = 0

require("config.lazy") -- Import `./lua/config/lazy.lua`

require("keymapping")

-- 设置当前行正文背景色
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#333333" })
-- 设置当前行号颜色
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#F3a701", bg = "#333333", bold = true })

-- Snacks profiler
if vim.env.PROF then
  -- example for lazy.nvim
  -- change this to the correct path for your plugin manager
  local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
  vim.opt.rtp:append(snacks)
  require("snacks.profiler").startup({
    startup = {
      event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
      -- event = "UIEnter",
      -- event = "VeryLazy",
    },
  })
end
