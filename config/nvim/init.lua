vim.g.mapleader = " "
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
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>")
vim.keymap.set("n", "<leader>e", "<cmd>Explore<cr>")
vim.keymap.set("n", "<leader>ff", "<cmd>find **/*<cr>")
vim.keymap.set("n", "<leader>fd", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({async=true}) end)
vim.diagnostic.config({virtual_text=true, severity_sort=true})
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger=true})
    end
    vim.keymap.set("n","gd",vim.lsp.buf.definition,{buffer=ev.buf})
    vim.keymap.set("n","gr",vim.lsp.buf.references,{buffer=ev.buf})
    vim.keymap.set("n","<leader>rn",vim.lsp.buf.rename,{buffer=ev.buf})
  end,
})
local servers = {
  rust_analyzer={"rust-analyzer"}, pyright={"pyright-langserver"},
  clangd={"clangd"}, vtsls={"vtsls"}, jdtls={"jdtls"},
  lua_ls={"lua-language-server"}, bashls={"bash-language-server"},
  jsonls={"vscode-json-language-server"}, yamlls={"yaml-language-server"},
}
for name, cmd in pairs(servers) do
  if vim.fn.executable(cmd[1]) == 1 and #vim.api.nvim_get_runtime_file("lsp/"..name..".lua",false)>0 then
    vim.lsp.enable(name)
  end
end
vim.cmd.colorscheme("habamax")
local function theme()
  local path = vim.fn.stdpath("config") .. "/colors-generated.lua"
  local ok, palette = pcall(dofile,path)
  if not ok or type(palette)~="table" then return end
  for group, attrs in pairs({
    Normal={fg=palette.fg,bg=palette.bg}, NormalFloat={fg=palette.fg,bg=palette.bg},
    CursorLine={bg=palette.surface}, Visual={bg=palette.surface},
    LineNr={fg=palette.muted}, CursorLineNr={fg=palette.accent,bold=true},
    FloatBorder={fg=palette.accent}, StatusLine={fg=palette.fg,bg=palette.surface},
  }) do vim.api.nvim_set_hl(0,group,attrs) end
end
theme()
vim.api.nvim_create_autocmd("FocusGained",{callback=theme})
vim.api.nvim_create_user_command("ThemeRefresh",theme,{})
