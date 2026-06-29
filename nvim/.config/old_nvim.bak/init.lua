vim.g.maplocalleader = "\\"
vim.g.mapleader = " "

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Neovim UI Settings
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true-- Relative line numbers for easy line navigation
vim.opt.cursorline = true -- Highlight the current line
vim.opt.signcolumn = "yes" -- Always show sign column (for gitsigns, LSP) to avoid text shifting
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<leader>l", "<cmd> Lazy <cr>")
vim.keymap.set("n", "<leader>pv", ":Ex<CR>")
-- set keymap for moving current line up and down
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==")
-- Suppress startup intro and common messages
vim.opt.shortmess:append("I")

-- Filter out all warnings from notifications (only show errors)
local original_notify = vim.notify
vim.notify = function(msg, level, opts)
  if level == vim.log.levels.WARN or level == "warn" then
    return
  end
  original_notify(msg, level, opts)
end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- Import all plugins from lua/plugins/ directory
    { import = "plugins" },
  },
  install = { colorscheme = { "catppuccin-mocha" } },
  checker = { enabled = true },
})
