local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, blink = pcall(require, "blink.cmp")
if ok then capabilities = blink.get_lsp_capabilities(capabilities) end
vim.lsp.config("*", {capabilities=capabilities})
vim.lsp.config("lua_ls", {settings={Lua={diagnostics={globals={"vim"}}}}})
vim.api.nvim_create_autocmd("LspAttach", {
  callback=function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not ok and client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true,client.id,ev.buf,{autotrigger=true})
    end
    local opts = {buffer=ev.buf}
    vim.keymap.set("n","gd",vim.lsp.buf.definition,opts)
    vim.keymap.set("n","gr",vim.lsp.buf.references,opts)
    vim.keymap.set("n","<leader>rn",vim.lsp.buf.rename,opts)
    vim.keymap.set("n","<leader>ca",vim.lsp.buf.code_action,opts)
  end,
})
local servers = {
  rust_analyzer="rust-analyzer", pyright="pyright-langserver",
  clangd="clangd", vtsls="vtsls", jdtls="jdtls",
  lua_ls="lua-language-server", bashls="bash-language-server",
  jsonls="vscode-json-language-server", yamlls="yaml-language-server",
}
for name, cmd in pairs(servers) do
  if vim.fn.executable(cmd)==1 and #vim.api.nvim_get_runtime_file("lsp/"..name..".lua",false)>0 then
    vim.lsp.enable(name)
  end
end
