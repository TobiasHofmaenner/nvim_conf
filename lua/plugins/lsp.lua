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
      local arduino_cli_config = os.getenv("ARDUINO_CLI_CONFIG")
          or "/home/ferrocoater/snap/arduino-cli/62/.arduino15/arduino-cli.yaml"

      vim.lsp.config("arduino_language_server", {
        cmd = {
          "arduino-language-server",
          "-clangd", "clangd",
          "-cli", "arduino-cli",
          "-cli-config", arduino_cli_config,
        },
      })
      vim.lsp.enable("arduino_language_server")

      vim.lsp.config("bashls", {
        capabilities = capabilities,
      })

      vim.lsp.config("texlab", {
        capabilities = capabilities,
      })
      vim.lsp.config("yamlls", {
        capabilities = capabilities,
        settings = {
          yaml = {
            schemaStore = {
              enable = true,
              url = "https://www.schemastore.org/api/json/catalog.json",
            },
            schemas = {
              ["https://kubernetes-schemas.pages.dev/apps/deployment_v1.json"] = "*/apps/*/deployment*.yaml",
              ["https://kubernetes-schemas.pages.dev/apps/statefulset_v1.json"] = "*/apps/*/statefulset*.yaml",
              ["https://kubernetes-schemas.pages.dev/apps/daemonset_v1.json"] = "*/apps/*/daemonset*.yaml",
              ["https://kubernetes-schemas.pages.dev/core/service_v1.json"] = "*/apps/*/service*.yaml",
              ["https://kubernetes-schemas.pages.dev/helm.toolkit.fluxcd.io/helmrelease_v2.json"] = "*/helm-release.yaml",
              ["https://kubernetes-schemas.pages.dev/source.toolkit.fluxcd.io/gitrepository_v1.json"] = "*/git-repository.yaml",
              ["https://kubernetes-schemas.pages.dev/kustomize.toolkit.fluxcd.io/kustomization_v1.json"] = "*/ks.yaml",
            },
            validate = true,
            completion = true,
            hover = true,
          },
        },
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

      vim.lsp.config("clangd", {
        capabilities = capabilities,
      })

      vim.lsp.config("pyright", {
        capabilities = capabilities,
      })

      vim.lsp.config("rust_analyzer", {
        capabilities = capabilities,
      })

      vim.lsp.config("gopls", {
        capabilities = capabilities,
      })

      vim.lsp.config("zls", {
        capabilities = capabilities,
      })

      vim.lsp.config("intelephense", {
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
          "clangd",
          "pyright",
          "rust_analyzer",
          "gopls",
          "zls",
          "intelephense",
          "texlab",
        },
        automatic_enable = true,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local map = function(keys, func, desc, mode)
            vim.keymap.set(mode or "n", keys, func, {
              buffer = event.buf,
              desc = "LSP: " .. desc,
            })
          end

          map("gd", vim.lsp.buf.definition, "Goto Definition")
          map("gr", vim.lsp.buf.references, "Goto References")
          map("gI", vim.lsp.buf.implementation, "Goto Implementation")
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })

          map("<leader>e", vim.diagnostic.open_float, "Line Diagnostics")
          map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
          map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
        end,
      })
    end,
  },
}
