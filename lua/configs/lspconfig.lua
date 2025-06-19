require("nvchad.configs.lspconfig").defaults()
local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities
local on_init = require("nvchad.configs.lspconfig").on_init

local servers = { "html", "cssls", "ts_ls", "tailwindcss", "pyright", "clangd", "jsonls", "eslint", "lua_ls", "texlab" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers

-- local function organize_imports()
--   local params = {
--     command = "_typescript.organizeImports",
--     arguments = { vim.api.nvim_buf_get_name(0) },
--   }
--   vim.lsp.buf.execute_command(params)
-- end
vim.lsp.config.pyright = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_dir = function(fname)
    return require("lspconfig.util").root_pattern("pyproject.toml", "setup.py", ".git")(fname)
  end,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}

vim.lsp.config.ts_ls = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
  -- commands = {
  --   OrganizeImports = {
  --     organize_imports,
  --     description = "Organize Imports",
  --   },
  -- },
}
-- vim.keymap.set("n", "<leader>co", organize_imports(), { desc = "Organize Imports" })

vim.lsp.config.eslint = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
}

vim.lsp.config.texlab = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "latex" },
}

vim.lsp.config.html = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "html" },
}

vim.lsp.config.cssls = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "css", "scss" }, -- you can add multiple
}

vim.lsp.config.lua_ls = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        enable = false, -- Disable all diagnostics from lua_ls
      },
      workspace = {
        library = {
          vim.fn.expand("$VIMRUNTIME/lua"),
          vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
          vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/love2d/library",
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

vim.lsp.config.clangd = {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    require("nvchad.configs.lspconfig").on_attach(client, bufnr)
  end,
}

-- vim.lsp.config.gopls = {
vim.lsp.config.ts_ls = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
  -- commands = {
  --   OrganizeImports = {
  --     organize_imports,
  --     description = "Organize Imports",
  --   },
  -- },
}
-- vim.keymap.set("n", "<leader>co", organize_imports(), { desc = "Organize Imports" })

vim.lsp.config.eslint = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
}

vim.lsp.config.texlab = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "latex" },
}

vim.lsp.config.html = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "html" },
}

vim.lsp.config.cssls = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "css", "scss" }, -- you can add multiple
}

vim.lsp.config.lua_ls = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        enable = false, -- Disable all diagnostics from lua_ls
      },
      workspace = {
        library = {
          vim.fn.expand("$VIMRUNTIME/lua"),
          vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
          vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/love2d/library",
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

vim.lsp.config.clangd = {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    require("nvchad.configs.lspconfig").on_attach(client, bufnr)
  end,
}

-- vim.lsp.config.gopls = {
--   on_attach = function(client, bufnr)
--     client.server_capabilities.documentFormattingProvider = false
--     client.server_capabilities.documentRangeFormattingProvider = false
--     require("nvchad.configs.lspconfig").on_attach(client, bufnr)
--   end,
--   cmd = { "gopls" },
--   filetypes = { "go", "gomod", "gotmpl", "gowork" },
--   root_dir = require("lspconfig").util.root_pattern("go.work", "go.mod", ".git"),
--   settings = {
--     gopls = {
--       analyses = {
--         unusedparams = true,
--       },
--       completeUnimported = true,
--       usePlaceholders = true,
--       staticcheck = true,
--     },
--   },
-- }
