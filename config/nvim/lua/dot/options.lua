local o = vim.opt
o.number = true
o.relativenumber = true
o.termguicolors = true
o.signcolumn = "yes"
o.ignorecase = true
o.smartcase = true
o.clipboard = "unnamedplus"
o.undofile = true
o.completeopt = {"menu", "menuone", "noselect"}
o.splitright = true
o.splitbelow = true
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.updatetime = 250
o.cursorline = true
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>")
vim.keymap.set("n", "<leader>fd", vim.diagnostic.open_float)
vim.diagnostic.config({virtual_text=true, severity_sort=true})
