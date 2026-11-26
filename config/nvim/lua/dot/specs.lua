return {
  {
    "nvim-neo-tree/neo-tree.nvim", branch="v3.x",
    dependencies={"nvim-lua/plenary.nvim","MunifTanjim/nui.nvim"},
    cmd="Neotree",
    keys={
      {"<C-b>","<cmd>Neotree filesystem toggle left<cr>",desc="Project tree"},
      {"<leader>b","<cmd>Neotree filesystem toggle left<cr>",desc="Project tree"},
    },
    opts={
      window={position="left",width=32},
      filesystem={
        hijack_netrw_behavior="disabled",
        filtered_items={hide_dotfiles=false,hide_gitignored=false,hide_by_name={".git","node_modules",".venv"}},
        follow_current_file={enabled=true},
      },
      default_component_configs={
        icon={folder_closed="+",folder_open="-",folder_empty=".",default=" "},
        git_status={symbols={added="+",modified="~",deleted="-",renamed=">",untracked="?",ignored=".",unstaged="!",staged="+",conflict="!"}},
      },
    },
  },
  {
    "saghen/blink.cmp", version="1.*", lazy=false,
    opts={
      keymap={preset="default"},
      fuzzy={implementation="lua"},
      completion={documentation={auto_show=true}},
      sources={default={"lsp","path","snippets","buffer"}},
    },
  },
  {
    "nvim-treesitter/nvim-treesitter", branch="main", lazy=false,
    build=":TSUpdate",
    config=function()
      require("nvim-treesitter").setup({})
      vim.api.nvim_create_autocmd("FileType", {
        callback=function(ev) pcall(vim.treesitter.start,ev.buf) end,
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies={"nvim-lua/plenary.nvim"},
    cmd="Telescope",
    keys={
      {"<leader>ff","<cmd>Telescope find_files<cr>",desc="Find files"},
      {"<leader>fg","<cmd>Telescope live_grep<cr>",desc="Search text"},
      {"<leader>fb","<cmd>Telescope buffers<cr>",desc="Buffers"},
    },
    opts={defaults={layout_strategy="horizontal"}},
  },
  {
    "stevearc/oil.nvim", cmd="Oil",
    keys={{"<leader>e","<cmd>Oil<cr>",desc="Explore files"}},
    opts={default_file_explorer=false,columns={}},
  },
  {
    "lewis6991/gitsigns.nvim", event={"BufReadPre","BufNewFile"},
    opts={signs={
      add={text="+"}, change={text="~"}, delete={text="_"},
      topdelete={text="^"}, changedelete={text="~"},
    }},
  },
  {
    "stevearc/conform.nvim", event="BufWritePre", cmd="ConformInfo",
    keys={{"<leader>f",function()
      require("conform").format({async=true,lsp_format="fallback"})
    end,desc="Format"}},
    opts={
      formatters_by_ft={
        lua={"stylua"}, python={"ruff_format"}, sh={"shfmt"}, bash={"shfmt"},
        rust={"rustfmt"}, c={"clang-format"}, cpp={"clang-format"},
        javascript={"prettier"}, javascriptreact={"prettier"},
        typescript={"prettier"}, typescriptreact={"prettier"},
        json={"prettier"}, jsonc={"prettier"}, yaml={"prettier"},
        html={"prettier"}, css={"prettier"}, markdown={"prettier"},
      },
      format_on_save=function(buf)
        if vim.bo[buf].buftype ~= "" or vim.b[buf].disable_autoformat then return end
        return {timeout_ms=1000,lsp_format="fallback"}
      end,
    },
  },
}
