vim.lsp.enable("rust_analyzer")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = {
      ensure_installed = { "rust", "toml" },
    },
    opts_extend = { "ensure_installed" },
  },

  {
    "mason-org/mason.nvim",
    optional = true,
    opts = {
      ensure_installed = {
        "rust-analyzer",
        "codelldb",
        "taplo", -- TOML language server and formatter
      },
    },
    opts_extend = { "ensure_installed" },
  },

  -- formatter
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        rust = { "rustfmt", lsp_format = "fallback" },
        toml = { "taplo" },
      },
    },
  },

  -- Enhanced Rust support with rustaceanvim
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false, -- This plugin is already lazy
    ft = { "rust" },
    init = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
          hover_actions = {
            replace_builtin_hover = false,
          },
        },
        -- LSP configuration
        server = {
          on_attach = function(_, bufnr)
            -- stylua: ignore
            local keymap_opts = function(desc) return { buffer = bufnr, desc = desc } end
            vim.keymap.set("n", "<leader>ca", function() vim.cmd.RustLsp("codeAction") end, keymap_opts("[Rust] Code action"))
            vim.keymap.set("n", "<leader>ce", function() vim.cmd.RustLsp("explainError") end, keymap_opts("[Rust] Explain error"))
            vim.keymap.set("n", "<leader>cR", function() vim.cmd.RustLsp("runnables") end, keymap_opts("[Rust] Runnables"))
            vim.keymap.set("n", "<leader>cD", function() vim.cmd.RustLsp("debuggables") end, keymap_opts("[Rust] Debuggables"))
            vim.keymap.set("n", "<leader>cT", function() vim.cmd.RustLsp("testables") end, keymap_opts("[Rust] Testables"))
            vim.keymap.set("n", "<leader>cm", function() vim.cmd.RustLsp("expandMacro") end, keymap_opts("[Rust] Expand macro"))
            vim.keymap.set("n", "<leader>cp", function() vim.cmd.RustLsp("parentModule") end, keymap_opts("[Rust] Parent module"))
            vim.keymap.set("n", "<leader>cJ", function() vim.cmd.RustLsp("joinLines") end, keymap_opts("[Rust] Join lines"))
            vim.keymap.set("n", "K", function() vim.cmd.RustLsp({ "hover", "actions" }) end, keymap_opts("[Rust] Hover actions"))
          end,
          default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              -- Add clippy lints for Rust
              checkOnSave = true,
              check = {
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
              inlayHints = {
                bindingModeHints = { enable = false },
                chainingHints = { enable = true },
                closingBraceHints = { enable = true, minLines = 25 },
                closureReturnTypeHints = { enable = "never" },
                lifetimeElisionHints = { enable = "never", useParameterNames = false },
                maxLength = 25,
                parameterHints = { enable = true },
                reborrowHints = { enable = "never" },
                renderColons = true,
                typeHints = {
                  enable = true,
                  hideClosureInitialization = false,
                  hideNamedConstructor = false,
                },
              },
            },
          },
        },
        -- DAP configuration
        dap = {},
      }
    end,
  },

  -- Crates.nvim for Cargo.toml
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        cmp = { enabled = false },
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>cu", function() require("crates").upgrade_all_crates() end, ft = "toml", desc = "[Crates] Upgrade all" },
      { "<leader>cU", function() require("crates").update_all_crates() end,  ft = "toml", desc = "[Crates] Update all" },
      { "<leader>ci", function() require("crates").show_popup() end,         ft = "toml", desc = "[Crates] Show info" },
      { "<leader>cf", function() require("crates").show_features_popup() end,ft = "toml", desc = "[Crates] Show features" },
      { "<leader>cv", function() require("crates").show_versions_popup() end,ft = "toml", desc = "[Crates] Show versions" },
    },
  },

  -- DAP configuration for Rust (using codelldb)
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")

      -- codelldb adapter (shared with C++)
      if not dap.adapters.codelldb then
        dap.adapters.codelldb = {
          type = "server",
          port = "${port}",
          executable = {
            command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
            args = { "--port", "${port}" },
          },
        }
      end

      -- Rust configurations
      dap.configurations.rust = {
        {
          name = "[Rust] Launch",
          type = "codelldb",
          request = "launch",
          program = function()
            -- Try to find the executable in target/debug
            local cwd = vim.fn.getcwd()
            local cargo_toml = cwd .. "/Cargo.toml"
            if vim.fn.filereadable(cargo_toml) == 1 then
              -- Read Cargo.toml to get package name
              local lines = vim.fn.readfile(cargo_toml)
              for _, line in ipairs(lines) do
                local name = line:match('^name%s*=%s*"([^"]+)"')
                if name then
                  local default_path = cwd .. "/target/debug/" .. name
                  if vim.fn.filereadable(default_path) == 1 then
                    return default_path
                  end
                  break
                end
              end
            end
            return vim.fn.input("Path to executable: ", cwd .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = function()
            local args_str = vim.fn.input("Arguments: ")
            return vim.split(args_str, " ", { plain = true })
          end,
          initCommands = function()
            -- Find out where to look for the pretty printer Python module
            local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))
            local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
            local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"
            local commands = {}
            local file = io.open(commands_file, "r")
            if file then
              for line in file:lines() do
                table.insert(commands, line)
              end
              file:close()
            end
            table.insert(commands, 1, script_import)
            return commands
          end,
        },
        {
          name = "[Rust] Launch (no args)",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
        {
          name = "[Rust] Attach to process",
          type = "codelldb",
          request = "attach",
          pid = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
    end,
  },
}
