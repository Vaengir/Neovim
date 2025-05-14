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
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    -- Bash LSP
    vim.lsp.config("bashls", {
      capabilities = capabilities,
    })
    vim.lsp.enable("bashls")

    -- C LSP
    vim.lsp.config("clangd", {
      capabilities = capabilities,
    })
    vim.lsp.enable("clangd")

    -- CSS LSP
    vim.lsp.config("cssls", {
      capabilities = capabilities,
    })
    vim.lsp.enable("cssls")

    -- Harper LSP
    vim.lsp.config("harper_ls", {
      capabilities = capabilities,
      settings = {
        ["harper-ls"] = {
          linters = {
            SpellCheck = true,
            SpelledNumbers = false,
            AnA = true,
            SentenceCapitalization = true,
            UnclosedQuotes = true,
            WrongQuotes = true,
            LongSentences = true,
            RepeatedWords = true,
            Spaces = true,
            Matcher = true,
            CorrectNumberSuffix = true,
          },
          codeActions = {
            ForceStable = false,
          },
          markdown = {
            IgnoreLinkTitle = false,
          },
          diagnosticSeverity = "hint",
          isolateEnglish = true,
          dialect = "British",
        },
      },
    })
    vim.lsp.enable("harper_ls")

    -- HTML LSP
    vim.lsp.config("html", {
      capabilities = capabilities,
    })
    vim.lsp.enable("html")

    -- Java LS
    vim.lsp.config("jdtls", {
      capabilities = capabilities,
      settings = {
        java = {
          format = {
            settings = { url = "~/.config/nvim/lua/vaengir/jdtls/formatter.xml", },
          },
        },
      },
    })
    vim.lsp.enable("jdtls")

    -- Kotlin LSP
    vim.lsp.config("kotlin_language_server", {
      capabilities = capabilities,
    })
    vim.lsp.enable("kotlin_language_server")

    -- Lua LS
    vim.lsp.config("lua_ls", {
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
    })
    vim.lsp.enable("lua_ls")

    -- Markdown LSP
    vim.lsp.config("marksman", {
      capabilities = capabilities,
    })
    vim.lsp.enable("marksman")

    -- Python LSP
    vim.lsp.config("pyright", {
      capabilities = capabilities,
    })
    vim.lsp.enable("pyright")

    -- Rust LSP
    vim.lsp.config("rust_analyzer", {
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
    })
    vim.lsp.enable("rust_analyzer")

    -- LaTeX LSP
    vim.lsp.config("texlab", {
      capabilities = capabilities,
    })
    vim.lsp.enable("texlab")

    -- TSServer LSP
    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
    })
    vim.lsp.enable("ts_ls")

    -- Zig LSP
    vim.lsp.config("zls", {
      capabilities = capabilities,
    })
    vim.lsp.enable("zls")

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
          { "<leader>kh", vim.lsp.buf.signature_help,                                                    desc = "Open signature ", },
          { "<leader>ki", vim.lsp.buf.implementation,                                                    desc = "Open LSP Implementation", },
          { "<leader>kI", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, desc = "Toggle Inlay Hints", },
          { "<leader>kn", function() require("vaengir.functions").jumpWithVirtLineDiags(1) end,          desc = "Goto next LSP Diagnostic", },
          { "<leader>kp", function() require("vaengir.functions").jumpWithVirtLineDiags(-1) end,         desc = "Goto previous LSP Diagnostic", },
          { "<leader>kr", "<cmd>Telescope lsp_references<cr>",                                           desc = "Show LSP References", },
          { "<leader>ks", "<cmd>Telescope lsp_document_symbols<cr>",                                     desc = "Find LSP elements in file", },
          { "<leader>kt", "<cmd>Telescope diagnostics<cr>",                                              desc = "Show LSP diagnostics", },
        })
      end,
    })
  end,
}
