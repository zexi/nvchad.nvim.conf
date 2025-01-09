require "nvchad.mappings"

-- add yours here

-- local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

local opts = {noremap = true, silent = true}

local keymap = vim.api.nvim_set_keymap

  -- wrapline up and down move
keymap("n", "k", "gk", opts)
keymap("n", "gk", "k", opts)
keymap("n", "j", "gj", opts)
keymap("n", "gj", "j", opts)

keymap("n", "<C-p>", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<C-e>", "<cmd>Telescope buffers cwd_only=true sort_mru=true<cr>", opts)
keymap("n", "<leader>b", "<cmd>Telescope diagnostics bufnr=0<cr>", opts)
-- keymap("n", "<leader>b", "<cmd>Telescope coc diagnostics<cr>", opts)
keymap("n", "<leader>*", "<cmd>lua require('telescope.builtin').grep_string({search = vim.fn.expand('<cword>')})<cr>",                                                                                                                            opts)

keymap("i", "<C-f>", "<Right>", opts)
keymap("i", "<C-b>", "<Left>", opts)

-- Command --
-- sudo write
keymap("c", "w!!", "w !sudo tee % >/dev/null", { noremap = true })
keymap("c", "<C-p>", "<Up>", { noremap = true })
keymap("c", "<C-n>", "<Down>", { noremap = true })

