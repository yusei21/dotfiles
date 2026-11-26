local function theme()
  vim.cmd.colorscheme("habamax")
  local groups = vim.api.nvim_get_hl(0, {})
  local function gray(c)
    local r = math.floor(c / 65536)
    local g = math.floor(c / 256) % 256
    local b = c % 256
    local v = math.floor(0.299*r + 0.587*g + 0.114*b + 0.5)
    return v*65793
  end
  for name, attrs in pairs(groups) do
    if not attrs.link then
      for _, k in ipairs({"fg", "bg", "sp"}) do
        if type(attrs[k]) == "number" then attrs[k] = gray(attrs[k]) end
      end
      attrs.ctermfg = nil
      attrs.ctermbg = nil
      pcall(vim.api.nvim_set_hl, 0, name, attrs)
    end
  end
  local p = dofile(vim.fn.stdpath("config") .. "/colors-generated.lua")
  for name, attrs in pairs({
    Normal={fg=p.fg,bg=p.bg}, NormalFloat={fg=p.fg,bg=p.bg},
    CursorLine={bg=p.surface}, Visual={bg=p.surface},
    LineNr={fg=p.muted}, CursorLineNr={fg=p.accent,bold=true},
    FloatBorder={fg=p.accent}, StatusLine={fg=p.fg,bg=p.surface},
  }) do vim.api.nvim_set_hl(0,name,attrs) end
end
theme()
vim.api.nvim_create_user_command("ThemeRefresh",theme,{})
