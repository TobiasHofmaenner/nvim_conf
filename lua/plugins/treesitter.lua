return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      { "nvim-treesitter/nvim-treesitter-context", commit = "v5.3.0" },
    },
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 3,
      })

      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "dockerfile",
          "git_config",
          "gitignore",
          "go",
          "helm",
          "hcl",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "regex",
          "toml",
          "vim",
          "vimdoc",
          "yaml",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
