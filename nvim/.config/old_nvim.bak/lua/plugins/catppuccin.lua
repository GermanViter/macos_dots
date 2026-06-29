---- catppuccin
--return {
--  {
--    "LazyVim/LazyVim",
--    opts = {
--      colorscheme = "catppuccin",
--    },
--  },
--  {
--    "catppuccin/nvim",
--    lazy = true,
--    name = "catppuccin",
--    config = function()
--      require("catppuccin").setup({
--        flavour = "mocha", -- latte, frappe, macchiato, mocha
--        transparent_background = true, -- disables setting the background color.
--        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
--        term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
--        dim_inactive = {
--          enabled = false, -- dims the background color of inactive window
--          shade = "dark",
--          percentage = 0.15, -- percentage of the shade to apply to the inactive window
--        },
--        no_italic = false, -- Force no italic
--        no_bold = false, -- Force no bold
--        lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
--          virtual_text = {
--            errors = { "italic" },
--            hints = { "italic" },
--            warnings = { "italic" },
--            information = { "italic" },
--            ok = { "italic" },
--          },
--          underlines = {
--            errors = { "underline" },
--            hints = { "underline" },
--            warnings = { "underline" },
--            information = { "underline" },
--            ok = { "underline" },
--          },
--          inlay_hints = {
--            background = true,
--          },
--        },
--        color_overrides = {},
--        custom_highlights = {},
--        default_integrations = true,
--        auto_integrations = false,
--        integrations = {
--          cmp = true,
--          gitsigns = true,
--          nvimtree = true,
--          notify = false,
--          mini = {
--            enabled = true,
--            indentscope_color = "",
--          },
--          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
--        },
--      })
--
--      -- setup must be called before loading
--      vim.cmd.colorscheme("catppuccin-nvim")
--    end,
--  },
--}

--matte black

-- return {
--   "tahayvr/matteblack.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme("matteblack")
--   end,
-- }
--
--
--
--
--
-- rosepine

return {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    require("rose-pine").setup({
      variant = "auto", -- auto, main, moon, or dawn
      dark_variant = "main", -- main, moon, or dawn
      dim_inactive_windows = false,
      extend_background_behind_borders = true,
      transparent_background = true,

      enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
      },

      styles = {
        transparency = true,
      },

      groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        note = "pine",
        todo = "rose",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",

        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
      },

      palette = {
        -- Override the builtin palette per variant
        -- moon = {
        --     base = '#18191a',
        --     overlay = '#363738',
        -- },
      },

      -- NOTE: Highlight groups are extended (merged) by default. Disable this
      -- per group via `inherit = false`
      highlight_groups = {
        -- Comment = { fg = "foam" },
        -- StatusLine = { fg = "love", bg = "love", blend = 15 },
        -- VertSplit = { fg = "muted", bg = "muted" },
        -- Visual = { fg = "base", bg = "text", inherit = false },
      },

      before_highlight = function(group, highlight, palette)
        -- Disable all undercurls
        -- if highlight.undercurl then
        --     highlight.undercurl = false
        -- end
        --
        -- Change palette colour
        -- if highlight.fg == palette.pine then
        --     highlight.fg = palette.foam
        -- end
      end,
    })
    vim.cmd("colorscheme rose-pine")
  end,
}
