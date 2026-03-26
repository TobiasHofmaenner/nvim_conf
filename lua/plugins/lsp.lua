return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "j-hui/fidget.nvim",
    },
    config = function()
      require("fidget").setup({})

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
            },
          },
        },
      })

      vim.lsp.config("bashls", {
        capabilities = capabilities,
      })

      vim.lsp.config("yamlls", {
        capabilities = capabilities,
      })

      vim.lsp.config("jsonls", {
        capabilities = capabilities,
      })

      vim.lsp.config("dockerls", {
        capabilities = capabilities,
      })

      vim.lsp.config("docker_compose_language_service", {
        capabilities = capabilities,
      })

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "bashls",
          "yamlls",
          "jsonls",
          "dockerls",
          "docker_compose_language_service",
        },
        automatic_enable = true,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd", vim.lsp.buf.definition, "Goto Definition")
          map("gr", vim.lsp.buf.references, "Goto References")
          map("gI", vim.lsp.buf.implementation, "Goto Implementation")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
          map("K", vim.lsp.buf.hover, "Hover Documentation")
        end,
      })
    end,
  },
}
