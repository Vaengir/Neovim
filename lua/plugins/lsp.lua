return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "j-hui/fidget.nvim",
      version = "*",
      event = "LspAttach",
      opts = {},
    },
    { "aznhe21/actions-preview.nvim", event = "LspAttach", },
  },
  event = { "BufReadPre", "BufNewFile", },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

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
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim", "beautiful", "awesome", "client", },
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
              quote_style = "double",
            },
          },
          telemetry = {
            enable = false,
          },
        },
      },
    }

    -- Markdown LSP
    lspconfig.marksman.setup {
      capabilities = capabilities,
    }

    -- Python LSP
    lspconfig.pyright.setup {
      capabilities = capabilities,
    }

    -- Rust LSP
    lspconfig.rust_analyzer.setup {
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          imports = {
            granularity = {
              group = "module",
            },
            prefix = "self",
          },
          cargo = {
            buildScripts = {
              enable = true,
            },
          },
          procMacro = {
            enable = true,
          },
          checkOnSave = {
            command = "clippy",
          },
          semanticHighlighting = {
            strings = {
              enable = false,
            },
          },
        },
      },
    }

    -- LaTeX LSP
    lspconfig.texlab.setup {
      capabilities = capabilities,
    }

    -- TSServer LSP
    lspconfig.ts_ls.setup {
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
        local keymap = vim.api.nvim_buf_set_keymap
        local options = { noremap = true, silent = true, }
        keymap(ev.buf, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", options)
        keymap(ev.buf, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", options)
        keymap(ev.buf, "n", "K", "<cmd>lua vim.lsp.buf.hover({ border = 'rounded', })<cr>", options)

        local make_input = function()
          vim.ui.input({ prompt = "Make argument: ", }, function(input)
            vim.cmd("Make! " .. input)
          end)
        end

        local makeprg_input = function()
          vim.ui.input({ prompt = "Build command: ", }, function(input)
            vim.cmd("set makeprg=" .. input)
          end)
        end

        whichkey.add({
          { "<leader>r",  "<cmd>LspRestart<cr>",    desc = "Restart Lsp Servers", },
          { "<leader>bb", "<cmd>AbortDispatch<cr>", desc = "Abort current make command", },
          {
            "<leader>bj",
            function()
              vim.cmd.cclose()
              make_input()
            end,
            desc = "Run make command",
          },
          {
            "<leader>bl",
            function()
              makeprg_input()
            end,
            desc = "Configure make command",
          },
          { "<leader>ka", require("actions-preview").code_actions, desc = "Code Action", },
          { "<leader>kc", vim.lsp.buf.rename,                      desc = "Rename using LSP", },
          {
            "<leader>kd",
            function()
              vim.diagnostic.enable(not vim.diagnostic.is_enabled())
              vim.notify("Diagnostics toggled\n", vim.log.levels.INFO)
            end,
            desc = "Toggle Diagnostics",
          },
          {
            "<leader>kf",
            function()
              vim.lsp.buf.format({ async = false, timeout_ms = 10000, })
              vim.notify("File formatted", vim.log.levels.INFO)
            end,
            desc = "Format",
          },
          { "<leader>kh", vim.lsp.buf.signature_help,                                                           desc = "Open signature ", },
          { "<leader>ki", vim.lsp.buf.implementation,                                                           desc = "Open LSP Implementation", },
          { "<leader>kI", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,        desc = "Toggle Inlay Hints", },
          { "<leader>kn", function() vim.diagnostic.jump({ count = 1, float = { border = "rounded", }, }) end,  desc = "Goto next LSP Diagnostic", },
          { "<leader>kp", function() vim.diagnostic.jump({ count = -1, float = { border = "rounded", }, }) end, desc = "Goto previous LSP Diagnostic", },
          { "<leader>kr", "<cmd>Telescope lsp_references<cr>",                                                  desc = "Show LSP References", },
          { "<leader>ks", "<cmd>Telescope lsp_document_symbols<cr>",                                            desc = "Find LSP elements in file", },
          { "<leader>kt", "<cmd>Telescope diagnostics<cr>",                                                     desc = "Show LSP diagnostics", },
        })
      end,
    })
  end,
}
