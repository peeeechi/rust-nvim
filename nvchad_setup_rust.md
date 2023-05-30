# set up `rust environment based NvChad`

- working_dir: ~/.config/nvim

## Code Completion

- lua/custon/chadrc.lua
```lua
---@type ChadrcConfig 
local M = {}
M.ui = {theme = 'catppuccin'}
M.plugins = "custom.plugins" -- add
return M
```

- lua/custom/plugins.lua (New file)
```lua
local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
      },
    },
  },
}

return plugins
```
- nvim quite
- reload nvim
- `:MasonInstallAll`

- lua/custom/plugins.lua

```lua
local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
      },
    },
  },
  -- update berow
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end    
  },
}

return plugins
```

- lua/custom/configs/lspconfig.lua (New file)

```lua
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetype = {"rust"},
    root_dir = util.root_pattern("Cargo.toml"),
    settings = {
        ['rust_analyzer'] = {
            cargo = {
                allFeature = true,
            }
        }
    }
})
```
