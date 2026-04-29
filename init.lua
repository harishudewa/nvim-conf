vim.g.mapleader = ' '
vim.g.autoformat = true

-- Using systemclipboard.
vim.opt.clipboard = 'unnamedplus'
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.shiftwidth = 1
vim.opt.softtabstop = 4

-- ===========================================================
-- PLUGINS
-- ===========================================================

vim.pack.add({
    'https://github.com/vague-theme/vague.nvim',
    'https://github.com/nvim-tree/nvim-tree.lua',
    'https://github.com/ibhagwan/fzf-lua',
    'https://github.com/nvim-mini/mini.nvim',
    'https://github.com/lewis6991/gitsigns.nvim',
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/stevearc/conform.nvim',
    'https://github.com/saghen/blink.lib',
    'https://github.com/saghen/blink.cmp',
})

-- ===========================================================
-- PLUGINS CONFIG
-- ===========================================================

-- /////////////////
-- vague color scheme
-- /////////////////

require('vague').setup({
    transparent = true,
})

vim.cmd.colorscheme('vague')

-- /////////////////
-- nvim-tree
-- /////////////////

require('nvim-tree').setup({
    view = { width = 35 },
    filters = { dotfiles = false },
    renderer = { group_empty = true },
})

vim.keymap.set('n', '<leader>e', function()
    require('nvim-tree.api').tree.toggle()
end, { desc = 'Toggle nvim-tree' })

-- /////////////////
-- fzf-lua fuzzy finder
-- /////////////////

require('fzf-lua').setup()

vim.keymap.set('n', '<leader>ff', function()
    require('fzf-lua').files()
end, { desc = 'FZF Files' })
vim.keymap.set('n', '<leader>fg', function()
    require('fzf-lua').live_grep()
end, { desc = 'FZF Live Grep' })
vim.keymap.set('n', '<leader>fb', function()
    require('fzf-lua').buffers()
end, { desc = 'FZF Buffers' })
vim.keymap.set('n', '<leader>fh', function()
    require('fzf-lua').help_tags()
end, { desc = 'FZF Help Tags' })
vim.keymap.set('n', '<leader>fx', function()
    require('fzf-lua').diagnostics_document()
end, { desc = 'FZF Diagnostics Document' })
vim.keymap.set('n', '<leader>fX', function()
    require('fzf-lua').diagnostics_workspace()
end, { desc = 'FZF Diagnostics Workspace' })

-- /////////////////
-- nvim mini
-- /////////////////

require('mini.ai').setup()
require('mini.comment').setup()
require('mini.move').setup()
require('mini.surround').setup()
require('mini.cursorword').setup()
require('mini.indentscope').setup()
require('mini.pairs').setup()
require('mini.trailspace').setup()
require('mini.bufremove').setup()
require('mini.notify').setup()
require('mini.icons').setup()
require('mini.statusline').setup()
-- require('mini.completion').setup()

-- /////////////////
-- gitsigns
-- /////////////////

require('gitsigns').setup({
    signs = {
        add = { text = '\u{2590}' },
        change = { text = '\u{2590}' },
        delete = { text = '\u{2590}' },
        topdelete = { text = '\u{25e6}' },
        changedelete = { text = '\u{25cf}' },
        untracked = { text = '\u{25cb}' },
    },
    signcolumn = true,
    current_line_blame = true,
})

vim.keymap.set('n', ']h', function()
    require('gitsigns').next_hunk()
end, { desc = 'Next git hunk' })
vim.keymap.set('n', '[h', function()
    require('gitsigns').prev_hunk()
end, { desc = 'Previous git hunk' })
vim.keymap.set('n', '<leader>hs', function()
    require('gitsigns').stage_hunk()
end, { desc = 'Stage hunk' })
vim.keymap.set('n', '<leader>hr', function()
    require('gitsigns').reset_hunk()
end, { desc = 'Reset hunk' })
vim.keymap.set('n', '<leader>hp', function()
    require('gitsigns').preview_hunk()
end, { desc = 'Preview hunk' })
vim.keymap.set('n', '<leader>hb', function()
    require('gitsigns').blame_line({ full = true })
end, { desc = 'Blame line' })
vim.keymap.set('n', '<leader>hB', function()
    require('gitsigns').toggle_current_line_blame()
end, { desc = 'Toggle inline blame' })
vim.keymap.set('n', '<leader>hd', function()
    require('gitsigns').diffthis()
end, { desc = 'Diff this' })

-- /////////////////
-- mason
-- /////////////////

require('mason').setup()

-- /////////////////
-- lspconfig
-- /////////////////

vim.lsp.enable('lua_ls')
vim.lsp.enable('svelte')
vim.lsp.enable('html')
vim.lsp.enable('cssls')
vim.lsp.enable('ts_ls')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('zls')

-- This is magic cmd to fix svelte syntax highlighting problem.
-- Reference: https://github.com/neovim/neovim/discussions/37552
vim.api.nvim_create_autocmd('BufEnter', {
    callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)
        if lang ~= nil and vim.treesitter.language.add(lang) then
            vim.treesitter.start(args.buf, lang)
        end
    end,
})

-- /////////////////
-- treesitter
-- /////////////////

require('nvim-treesitter').install({ 'svelte', 'lua', 'typescript', 'html', 'css', 'rust', 'zig' })

-- /////////////////
-- conform
-- /////////////////

require('conform').setup({
    formatters_by_ft = {
        lua = { 'stylua' },
        typescript = { 'prettierd' },
        svelte = { 'prettierd' },
        rust = { lsp = 'fallback' },
        zig = { lsp = 'fallback' },
    },
    format_on_save = {
        timeout_ms = 2000,
        lsp_format = 'fallback',
    },
})

-- /////////////////
-- blink.cmp
-- /////////////////

local cmp = require('blink.cmp')
cmp.build():wait(60000)
cmp.setup({
    completion = {
        menu = {
            draw = {
                columns = {
                    { 'label', 'label_description', gap = 1 },
                    { 'kind_icon', 'kind' },
                },
            },
        },
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        ghost_text = { enabled = true },
    },
    signature = { enabled = true },
})
