-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  local result = vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
  if vim.v.shell_error ~= 0 then
    -- stylua: ignore
    vim.api.nvim_echo({ { ("Error cloning lazy.nvim:\n%s\n"):format(result), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
    vim.fn.getchar()
    vim.cmd.quit()
  end
end

vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"

vim.lsp.inlay_hint.enable(true)

vim.keymap.set("n", "<C-b>", "<Cmd>Neotree toggle<CR>")
vim.keymap.set("i", "<C-b>", "<Cmd>Neotree toggle<CR>")

vim.keymap.set("n", "<C-Up>", "5k")
vim.keymap.set("n", "<C-Down>", "5j")
vim.keymap.set("i", "<C-Up>", "<Esc>5k$i")
vim.keymap.set("i", "<C-Down>", "<Esc>5j$i")

-- Should enable inlay hints but doesn't really work
vim.lsp.inlay_hint.enable(true)

-- Set status column to show only absolute numbers
vim.opt.number = true
vim.opt.relativenumber = false

-- Enable mouse usage
vim.opt.mouse = "a"

vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { noremap = true, silent = true })

-- Enable telescope shortcuts
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Helper for goto-line
vim.keymap.set("n", "<C-g>", ":", { noremap = true })

vim.keymap.set('n', '<C-p>', function()
  require('telescope.builtin').find_files()
end, { desc = "Find files" })