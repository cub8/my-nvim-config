local keymap = vim.keymap

return {
	-- Editor theme
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
      local kanagawa = require("kanagawa")

      kanagawa.setup({
        commentStyle = { italic = false },
        functionStyle = { bold = true, italic = false },
        keywordStyle = { bold = true, italic = false },
        dimInactive = true,
        theme = "wave",
      })

			vim.cmd("colorscheme kanagawa")
		end
	},
  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local lualine = require("lualine")

      lualine.setup()
    end
  },
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
    },
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        sync_install = false,
        ensure_installed = {
          -- nvim
          "vim", "vimdoc", "lua",
          -- misc
          "comment", "dockerfile", "json", "yaml", "toml", "regex",
          -- git
          "gitcommit", "gitignore", "diff",
          -- shell
          "bash",
          -- markdown
          "markdown", "markdown_inline",
          -- webdev
          "html", "css", "scss", "javascript", "jsdoc", "typescript", "tsx", "vue",
          -- ruby
          "ruby",
          -- go
          "go",
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        endwise = {
          enable = true
        },
      })
    end,
    init = function()
      vim.treesitter.language.register("markdown", "mdx")
    end,
  },
  -- Mini
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      require("mini.pairs").setup()
      require("mini.cursorword").setup()
      require("mini.comment").setup()
    end
  },
  -- Alpha
  {
    'goolord/alpha-nvim',
    event = "VimEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      alpha.setup(dashboard.opts)
    end
  },
  -- Better whitespace
  {
    "johnfrankmorgan/whitespace.nvim",
    config = function()
      require("whitespace-nvim").setup({
        highlight = "DiffDelete",
        ignored_filetypes = {
          "TelescopePrompt",
          "Trouble",
          "help",
        },
        ignore_terminal = true,
      })

      keymap.set("n","<leader>t", require("whitespace-nvim").trim)
    end
  },
  -- Pair brackets
  {
    'fedepujol/bracketpair.nvim',
    config = function()
      require("bracketpair")
    end
  },
  -- Telescope, remember to install ripgrep!!!
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local builtin = require("telescope.builtin")

      keymap.set("n", "<space>ff", builtin.find_files)
      keymap.set("n", "<space>fg", builtin.live_grep)
      keymap.set("n", "<space>fb", builtin.buffers)
      keymap.set("n", "<space>fh", builtin.help_tags)
    end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function ()
      local neotree = require("neo-tree")
    end
  },
  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local config = require("bufferline")
      local map_gotobuffer = function(num)
       keymap.set("n", "<leader>" .. num,  ":BufferLineGoToBuffer " .. num .. "<cr>")
      end

      config.setup({})
      keymap.set("n", "<S-Right>",  ":bNext<cr>")
      keymap.set("n", "<S-Left>",   ":bprevious<cr>")
      keymap.set("n", "<leader>d",  ":bdelete<cr>")

      for i = 1, 10, 1 do
        map_gotobuffer(i)
      end
    end
  },
  -- Git diffviewer
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
  },
  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gitsigns = require("gitsigns")

      gitsigns.setup()
    end
  },
  -- LS configs
  {
    "neovim/nvim-lspconfig",
    config = require("configs/lsp"),
  },
  -- Snippet engine
  {
    "L3MON4D3/LuaSnip",
    version = "2.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function ()
      require("luasnip.loaders.from_vscode").lazy_load()
    end
  },
  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
    },
    config = require("configs/cmp"),
  },
  -- Mason
  {
    "williamboman/mason.nvim",
    config = function()
      local mason = require("mason")
      mason.setup()
    end,
  },
  -- Automatic language server install
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local config = require("mason-lspconfig")

      config.setup({
        automatic_installation = true,

        ensure_installed = {
          "lua_ls",
          "html",
          "cssls",
          "solargraph",
          "yamlls",
          "quick_lint_js",
          "gopls",
          "elixirls",
        }
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      config.setup_handlers({
        function(server)
          lspconfig[server].setup({
            single_file_support = true,
            capabilities = capabilities,
          })
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            single_file_support = true,
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = {
                    "vim"
                  }
                }
              }
            }
          })
        end,
      })
    end,
  }
}
