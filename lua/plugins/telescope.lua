return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
	local builtin = require('telescope.builtin')
	-- [P]roject
	vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
	vim.keymap.set('n', '<leader>pg', builtin.git_files, { desc = 'Telescope find git files' })
	vim.keymap.set('n', '<leader>pw', builtin.live_grep, { desc = 'Telescope live grep' })
	vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = 'Telescope buffers' })

	-- General [F]ind
	vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
	vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope keymap' })
	vim.keymap.set('n', '<leader>fc', function ()
	    builtin.find_files({
		cwd = vim.fn.stdpath('config')
	    })
	end, { desc = 'Telescope find config files' })
    end
}
