local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities


local options = {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    -- use clippy
    -- ref: https://users.rust-lang.org/t/setup-neovim-0-5-for-rust/60183
    settings = {
      ["rust-analyzer"] = {
        assist = {
          importMergeBehavior = "last",
          importPrefix = "by_self",
        },
        diagnostics = {
          disabled = { "unresolved-import" }
        },
        cargo = {
            loadOutDirsFromCheck = true
        },
        procMacro = {
            enable = true
        },
        checkOnSave = {
            command = "clippy"
        },
      },
    },
  },
}

return options
