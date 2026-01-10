vim.lsp.enable("clangd")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = {
      ensure_installed = { "c", "cpp", "cmake", "make" },
    },
    opts_extend = { "ensure_installed" },
  },

  {
    "mason-org/mason.nvim",
    optional = true,
    opts = {
      ensure_installed = {
        "clangd",
        "clang-format",
        "codelldb",
        "cmake-language-server",
        "cmakelint",
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
        c = { "clang-format" },
        cpp = { "clang-format" },
        cmake = { "cmake_format" },
      },
    },
  },

  -- linter
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        cmake = { "cmakelint" },
      },
    },
  },

  -- Enhanced clangd support
  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    opts = {
      inlay_hints = {
        inline = false,
      },
      ast = {
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    },
  },

  -- DAP configuration for C/C++
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")

      -- codelldb adapter
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        },
      }

      -- C/C++ configurations
      dap.configurations.cpp = {
        {
          name = "[C++] Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = function()
            local args_str = vim.fn.input("Arguments: ")
            return vim.split(args_str, " ", { plain = true })
          end,
        },
        {
          name = "[C++] Launch file (no args)",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
        {
          name = "[C++] Attach to process",
          type = "codelldb",
          request = "attach",
          pid = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }

      -- Use the same configuration for C
      dap.configurations.c = dap.configurations.cpp
    end,
  },

  -- CMake integration
  {
    "Civitasv/cmake-tools.nvim",
    lazy = true,
    ft = { "c", "cpp", "cmake" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      cmake_command = "cmake",
      ctest_command = "ctest",
      cmake_build_directory = "build/${variant:buildType}",
      cmake_soft_link_compile_commands = true,
      cmake_compile_commands_from_lsp = false,
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
    },
    -- stylua: ignore
    keys = {
      { "<leader>cg", "<CMD>CMakeGenerate<CR>",       ft = { "c", "cpp", "cmake" }, desc = "[CMake] Generate" },
      { "<leader>cb", "<CMD>CMakeBuild<CR>",          ft = { "c", "cpp", "cmake" }, desc = "[CMake] Build" },
      { "<leader>cr", "<CMD>CMakeRun<CR>",            ft = { "c", "cpp", "cmake" }, desc = "[CMake] Run" },
      { "<leader>cd", "<CMD>CMakeDebug<CR>",          ft = { "c", "cpp", "cmake" }, desc = "[CMake] Debug" },
      { "<leader>ct", "<CMD>CMakeSelectBuildType<CR>",ft = { "c", "cpp", "cmake" }, desc = "[CMake] Select build type" },
      { "<leader>cs", "<CMD>CMakeSelectConfigurePreset<CR>", ft = { "c", "cpp", "cmake" }, desc = "[CMake] Select configure preset" },
    },
  },
}
