return {
  {
    "greggh/claude-code.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("claude-code").setup({
        window = {
          position = "botright",
          split_ratio = 0.3,
          enter_insert = true,
          hide_numbers = true,
          hide_signcolumn = true,
        },
        git = {
          use_git_root = true,
        },
        keymaps = {
          toggle = {
            normal = "<leader>ac",
            terminal = "<leader>ac",
            variants = {
              continue = "<leader>aC",
              verbose = "<leader>aV",
            },
          },
          window_navigation = true,
          scrolling = true,
        },
      })
    end,
  },
}
