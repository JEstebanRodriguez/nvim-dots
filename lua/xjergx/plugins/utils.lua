return {
  {
  "aznhe21/actions-preview.nvim",
  config = function()
    vim.keymap.set({ "v", "n" }, "<leader>ca", require("actions-preview").code_actions, { desc = "Code Actions" })
  end,
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
local rainbow_delimiters = require 'rainbow-delimiters'

vim.g.rainbow_delimiters = {
    strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
    },
    query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
    },
    priority = {
        [''] = 110,
        lua = 210,
    },
    highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
    },
}
    end
  },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {}
      vim.keymap.set("n", "<leader>z", ":ZenMode<cr>", { desc = "Zen Mode" })
    end
  },
  {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
     require('ts_context_commentstring').setup {
  enable_autocmd = false
}    end
  },
  {
    'numToStr/Comment.nvim',
    config = true
    -- opts = {
    --   pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    -- },
    -- config = function(_, opts)
    --   require('Comment').setup(opts)
    -- end
}
}
