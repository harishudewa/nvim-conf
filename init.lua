vim.g.mapleader = " "

-- Using systemclipboard.
vim.opt.clipboard = "unnamedplus"
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.number = true


-- ===========================================================
-- PLUGINS
-- ===========================================================

vim.pack.add({
  "https://github.com/vague-theme/vague.nvim",
  "https://github.com/nvim-tree/nvim-tree.lua",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/lewis6991/gitsigns.nvim"
})


-- ===========================================================
-- PLUGINS CONFIG
-- ===========================================================

-- /////////////////
-- vague color scheme
-- /////////////////

require("vague").setup({
  transparent = true
})

vim.cmd.colorscheme("vague")

-- /////////////////
-- nvim-tree
-- /////////////////

require("nvim-tree").setup({
  view = { width = 35 },
  filters = { dotfiles = false },
  renderer = { group_empty = true }
})

vim.keymap.set("n", "<leader>e", function()
  require("nvim-tree.api").tree.toggle()
end, { desc = "Toggle nvim-tree" })

-- /////////////////
-- fzf-lua fuzzy finder
-- /////////////////

require("fzf-lua").setup()

vim.keymap.set("n", "<leader>ff", function()
  require("fzf-lua").files()
end, { desc = "FZF Files" })
vim.keymap.set("n", "<leader>fg", function()
  require("fzf-lua").live_grep()
end, { desc = "FZF Live Grep" })
vim.keymap.set("n", "<leader>fb", function()
  require("fzf-lua").buffers()
end, { desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>fh", function()
  require("fzf-lua").help_tags()
end, { desc = "FZF Help Tags" })
vim.keymap.set("n", "<leader>fx", function()
  require("fzf-lua").diagnostics_document()
end, { desc = "FZF Diagnostics Document" })
vim.keymap.set("n", "<leader>fX", function()
  require("fzf-lua").diagnostics_workspace()
end, { desc = "FZF Diagnostics Workspace" })

-- /////////////////
-- nvim mini
-- /////////////////

require("mini.ai").setup()
require("mini.comment").setup()
require("mini.move").setup()
require("mini.surround").setup()
require("mini.cursorword").setup()
require("mini.indentscope").setup()
require("mini.pairs").setup()
require("mini.trailspace").setup()
require("mini.bufremove").setup()
require("mini.notify").setup()
require("mini.icons").setup()
require("mini.statusline").setup()

-- /////////////////
-- gitsigns
-- /////////////////

require("gitsigns").setup({
  signs = {
    add = { text = "\u{2590}" },
    change = { text = "\u{2590}" },
    delete = { text = "\u{2590}" },
    topdelete = { text = "\u{25e6}" },
    changedelete = { text = "\u{25cf}" },
    untracked = { text = "\u{25cb}" }
  },
  signcolumn = true,
  current_line_blame = true
})

