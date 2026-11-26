local path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(path) then
  local output = vim.fn.system({"git","clone","--filter=blob:none","--branch=stable","https://github.com/folke/lazy.nvim.git",path})
  if vim.v.shell_error ~= 0 then
    vim.notify("lazy.nvim bootstrap failed: "..output,vim.log.levels.ERROR)
    return
  end
end
vim.opt.rtp:prepend(path)
require("lazy").setup("dot.specs", {
  rocks={enabled=false},
  performance={rtp={paths={vim.fn.stdpath("data") .. "/site", "/usr/share/nvim/site/pack/dist/start/lspconfig"}}},
  checker={enabled=false},
  change_detection={notify=false},
  install={colorscheme={"habamax"}},
})
