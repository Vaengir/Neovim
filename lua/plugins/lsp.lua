return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "j-hui/fidget.nvim",
      event = "LspAttach",
      opts = {},
    },
    { "aznhe21/actions-preview.nvim", event = "LspAttach", },
  },
  event = "LspAttach",
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Bash LSP
    lspconfig.bashls.setup {
      capabilities = capabilities,
    }

    -- CSS LSP
    lspconfig.cssls.setup {
      capabilities = capabilities,
    }

    -- HTML LSP
    lspconfig.html.setup {
      capabilities = capabilities,
    }

    -- Java LS
    lspconfig.jdtls.setup {
      capabilities = capabilities,
      settings = {
        java = {
          format = {
            settings = { url = "~/.config/nvim/lua/weiberle/jdtls/formatter.xml", },
          },
        },
      },
    }

    -- Kotlin LSP
    lspconfig.kotlin_language_server.setup {
      capabilities = capabilities,
    }

    -- Lua LS
    lspconfig.lua_ls.setup {
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = { 'vim', 'beautiful', 'awesome', 'client', },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.stdpath "config" .. "/lua"] = true,
            },
          },
          format = {
            enable = true,
            defaultConfig = {
              indent_style = "space",
              indent_size = "2",
              max_line_length = "unset",
              trailing_table_separator = "always",
            },
          },
          telemetry = {
            enable = false,
          },
        },
      },
    }

    -- Rust LSP
    lspconfig.rust_analyzer.setup {
      capabilities = capabilities,
    }

    -- LaTeX LSP
    lspconfig.texlab.setup {
      capabilities = capabilities,
    }

    -- TSServer LSP
    lspconfig.tsserver.setup {
      capabilities = capabilities,
    }

    -- Better icons
    vim.fn.sign_define("DiagnosticSignError", { text = "󰅚 ", texthl = "DiagnosticSignError", })
    vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn", })
    vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo", })
    vim.fn.sign_define("DiagnosticSignHint", { text = "󰌶 ", texthl = "DiagnosticSignHint", })

    -- On attach
    local whichkey = require("which-key")
    local autocmd = vim.api.nvim_create_autocmd
    autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = {
          mode = "n",
          prefix = "<leader>",
          buffer = ev.buf,
          silent = true,
          noremap = true,
          nowait = true,
        }

        local mappings = {
          k = {
            name = "LSP",
            a = { require("actions-preview").code_actions, "Code Action", },
            b = { vim.lsp.buf.hover, "Show LSP Info", },
            c = { vim.lsp.buf.rename, "Rename using LSP", },
            d = { vim.lsp.buf.definition, "Open LSP Definition", },
            f = { function() vim.lsp.buf.format({ async = false, timeout_ms = 10000, }) end, "Format", },
            i = { vim.lsp.buf.implementation, "Open LSP Implementation", },
            n = { vim.diagnostic.goto_next, "Goto next LSP Diagnostic", },
            p = { vim.diagnostic.goto_prev, "Goto previous LSP Diagnostic", },
            r = { require('telescope.builtin').lsp_references, "Show LSP References", },
            t = { "<cmd>Telescope diagnostics<cr>", "Show LSP diagnostics", },
          },
        }

        whichkey.register(mappings, opts)
      end,
    })
  end,
}