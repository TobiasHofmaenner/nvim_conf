return {
  {
    "laytan/cloak.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true,
      cloak_character = "*",
      highlight_group = "Comment",
      patterns = {
        {
          file_pattern = {
            ".env*",
            "wrangler.toml",
            "*.tfvars",
            "*.tfvars.json",
            "secrets.yaml",
            "values.yaml",
            "*/templates/*.yaml",
          },
          cloak_pattern = {
            "=.+",
            ": .+",
          },
        },
      },
    },
    config = function(_, opts)
      require("cloak").setup(opts)

      vim.keymap.set("n", "<leader>cc", "<cmd>CloakToggle<cr>", { desc = "Toggle cloak" })
    end,
  },
}
