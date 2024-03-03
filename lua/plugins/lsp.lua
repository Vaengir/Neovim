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

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })

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
        keymap(ev.buf, "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", options)

        local make_input = function()
          vim.ui.input({ prompt = "Make argument: ", }, function(input)
            vim.cmd("make!" .. input)
            vim.api.nvim_feedkeys("<cr>", "n", true)
          end)
        end

        local makeprg_input = function()
          vim.ui.input({ prompt = "Build command: ", }, function(input)
            vim.cmd("set makeprg=" .. input)
          end)
        end

        local opts = {
          mode = "n",
          prefix = "<leader>",
          buffer = ev.buf,
          silent = true,
          noremap = true,
          nowait = true,
        }

        local mappings = {
          b = {
            name = "Build",
            j = { function()
              make_input()
              vim.cmd("cw")
            end, "Run make command", },
            k = { function()
              makeprg_input()
            end, "Configure make command", },
            l = { require("functions").toggle_qf, "Toggle Quickfix List", },
          },
          k = {
            name = "LSP",
            a = { require("actions-preview").code_actions, "Code Action", },
            c = { vim.lsp.buf.rename, "Rename using LSP", },
            d = { function()
              if vim.diagnostic.is_disabled(0) then
                vim.diagnostic.enable(0)
                print("Diagnostics enabled")
              else
                vim.diagnostic.disable(0)
                print("Diagnostics disabled")
              end
            end, "Toggle Diagnostics", },
            f = { function()
              vim.lsp.buf.format({ async = false, timeout_ms = 10000, })
              print("File formatted")
            end, "Format", },
            h = { vim.lsp.buf.signature_help, "Open signature help", },
            i = { vim.lsp.buf.implementation, "Open LSP Implementation", },
            n = { vim.diagnostic.goto_next, "Goto next LSP Diagnostic", },
            p = { vim.diagnostic.goto_prev, "Goto previous LSP Diagnostic", },
            r = { require("telescope.builtin").lsp_references, "Show LSP References", },
            t = { "<cmd>Telescope diagnostics<cr>", "Show LSP diagnostics", },
          },
        }

        whichkey.register(mappings, opts)
      end,
    })
  end,
}
