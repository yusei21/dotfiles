local M = {}
local function terminal(argv, cwd)
  vim.cmd("botright 12new")
  vim.bo.bufhidden = "wipe"
  vim.wo.number = false
  vim.wo.relativenumber = false
  local job = vim.fn.jobstart(argv, {term=true, cwd=cwd})
  if job <= 0 then
    vim.notify("Could not start command", vim.log.levels.ERROR)
    return
  end
  vim.cmd.startinsert()
end

function M.run(build)
  local buf = vim.api.nvim_get_current_buf()
  if vim.bo[buf].buftype ~= "" or vim.api.nvim_buf_get_name(buf) == "" then
    vim.notify("Open a source file first", vim.log.levels.WARN)
    return
  end
  local file = vim.api.nvim_buf_get_name(buf)
  local ft = vim.bo[buf].filetype
  local dir = vim.fs.dirname(file)
  local argv, cwd
  local cargo = ft == "rust" and vim.fs.find("Cargo.toml", {path=dir, upward=true})[1]
  if cargo then
    cwd = vim.fs.dirname(cargo)
    argv = {"cargo", build and "build" or "run"}
  elseif ft == "c" or ft == "cpp" or ft == "rust" then
    local compiler = ({c="gcc", cpp="g++", rust="rustc"})[ft]
    if build then
      argv = {compiler, file, "-o", file .. ".out"}
    else
      argv = {"bash", "-c", 'set -e; d=$(mktemp -d); trap \'rm -rf -- "$d"\' EXIT; "$1" "$2" -o "$d/program"; "$d/program"', "dot-run", compiler, file}
    end
  elseif ft == "java" then
    argv = {build and "javac" or "java", file}
  elseif not build then
    local interpreter = ({python="python", javascript="node", typescript="node", sh="bash", bash="bash"})[ft]
    if interpreter then argv = {interpreter, file} end
  end
  if not argv then
    vim.notify("No " .. (build and "build" or "run") .. " command for " .. ft, vim.log.levels.WARN)
    return
  end
  local ok, err = pcall(vim.cmd.update)
  if not ok then vim.notify(tostring(err), vim.log.levels.ERROR); return end
  terminal(argv, cwd or dir)
end

vim.keymap.set("n", "<F5>", function() M.run(false) end, {desc="Run code"})
vim.keymap.set("n", "<leader>r", function() M.run(false) end, {desc="Run code"})
vim.keymap.set("n", "<F6>", function() M.run(true) end, {desc="Build code"})
vim.keymap.set("n", "<leader>t", function() terminal({vim.o.shell}, vim.fn.getcwd()) end, {desc="Terminal"})
vim.keymap.set({"n","i"}, "<C-s>", "<cmd>update<cr>", {desc="Save"})
vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], {desc="Terminal normal mode"})
return M
