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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.signcolumn = "yes"

vim.opt.cursorline = false
vim.api.nvim_set_hl(0, 'CursorLine', { underline = true, fg = 'NONE', bg = 'NONE' })

vim.opt.guicursor = ""

vim.keymap.set('n', '<leader>x', ':.lua<cr>')
vim.keymap.set('v', '<leader>x', ':.lua<cr>')
vim.keymap.set('n', '<leader>X', '<cmd>source %<cr>')
vim.keymap.set('n', '<leader>xp', vim.cmd.Ex)

vim.keymap.set('i', '<C-c>', '<Esc>');
vim.keymap.set('n', "<M-j>", '<cmd>cnext<CR>zz')
vim.keymap.set('n', "<M-k>", '<cmd>cprev<CR>zz')

vim.keymap.set('v', 'J', ":m '>+1'<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2'<CR>gv=gv")

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

vim.keymap.set('n', '<leader>cx', ':!chmod +x %<cr>');

vim.keymap.set('n', '<leader>cgn', '*N_cgn');

vim.keymap.set('n', '<M-=>', '<C-w>+')
vim.keymap.set('n', '<M-->', '<C-w>-')
vim.keymap.set('n', '<M-,>', '<C-w><')
vim.keymap.set('n', '<M-.>', '<C-w>>')

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = "Highlight after yanking test",
    group = vim.api.nvim_create_augroup('highlight-yank-text', { clear = true }),
    callback = function ()
	vim.highlight.on_yank()
    end
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
    desc = "run clangd lsp in c file",
    pattern = {'*.c', '*.h', '*.hpp', '*.cpp'},
    group = vim.api.nvim_create_augroup('run-clangd', { clear = true }),
    callback = function ()
	vim.lsp.enable('clangd')
    end
})

vim.api.nvim_create_autocmd('BufWritePost', {
    desc = 'Format python code',
    pattern = {'*.py'},
    group = vim.api.nvim_create_augroup('format-python', { clear = true }),
    callback = function ()
	local fileName = vim.api.nvim_buf_get_name(0)
        vim.cmd(":silent !black --preview -q " .. fileName)
    end
})

function NoBackground()
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })
end

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
