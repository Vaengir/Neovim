return {
  "laytan/cloak.nvim",
  opts = {
    enabled = true,
    highlight_group = "Comment",
    patterns = {
      {
        file_pattern = {
          ".env*",
          "wrangler.toml",
          ".dev.vars",
        },
        cloak_pattern = "=.+",
      },
    },
  },
}
