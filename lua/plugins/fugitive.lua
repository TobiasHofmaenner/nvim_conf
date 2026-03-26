return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
        json = { "jq" },
        yaml = { "prettier" },
        markdown = { "prettier" },
      },
      format_on_save = function(bufnr)
        return { timeout_ms = 500, lsp_format = "fallback" }
      end,
    },
  },
}
