return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop", },
    ft = { "markdown", },
    build = function() vim.fn["mkdp#util#install"]() end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview", },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons", },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      bullet = {
        right_pad = 1,
      },
      code = {
        border = "thick",
        left_pad = 2,
        min_width = 120,
        position = "right",
        right_pad = 4,
        sign = false,
        style = "full",
        width = "block",
      },
      completions = {
        lsp = {
          enabled = true,
        },
      },
      heading = {
        backgrounds = {},
      },
    },
    keys = {
      { "<leader>mt", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Render Markdown", },
    },
  },
}
