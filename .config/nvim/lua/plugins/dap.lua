return {
  {
    "igorlfs/nvim-dap-view",
    dependencies = {
      {
        -- Solve the display issue with lualine
        "nvim-lualine/lualine.nvim",
        optional = true,
        opts = { options = { disabled_filetypes = { winbar = { "dap-view", "dap-view-term", "dap-repl" } } } },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>Du", function() require("dap-view").toggle() end, desc = "[DAP view] Toggle dap-view" },
    },
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {
      winbar = {
        sections = { "scopes", "repl", "watches", "breakpoints", "exceptions" },
        default_section = "scopes",
        controls = {
          enabled = true,
        },
      },
      windows = {
        -- height = 0.25,
        position = "below",
        terminal = {
          -- width = 0.1,
          position = "right",
          -- List of debug adapters for which the terminal should be ALWAYS hidden
          hide = {},
        },
      },
      help = {
        border = "rounded",
      },
      auto_toggle = true,
    },
  },

  {
    -- Show variable values as virtual texts
    "theHamsta/nvim-dap-virtual-text",
    enabled = false, -- Disabled by default
    opts = {
      virt_text_pos = "eol",
    },
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "igorlfs/nvim-dap-view",
    },
    -- stylua: ignore
    keys = {
      { "<F5>",       function() require("dap").continue() end,                                                        mode = "n",          desc = "[DAP] Continue" },
      { "<F6>",       function() require("dap").step_over() end,                                                       mode = "n",          desc = "[DAP] Step over" },
      { "<F7>",       function() require("dap").step_into() end,                                                       mode = "n",          desc = "[DAP] Step into" },
      { "<F8>",       function() require("dap").step_out() end,                                                        mode = "n",          desc = "[DAP] Step out" },
      { "<F9>",       function() require("dap").pause() end,                                                           mode = "n",          desc = "[DAP] Pause" },
      { "<F10>",      function() require("dap").terminate() end,                                                       mode = "n",          desc = "[DAP] Terminate" },
      -- Alternative keymaps using <Leader>D prefix (if F-keys don't work in terminal)
      { "<Leader>Dc", function() require("dap").continue() end,                                                        mode = "n",          desc = "[DAP] Continue" },
      { "<Leader>Do", function() require("dap").step_over() end,                                                       mode = "n",          desc = "[DAP] Step over" },
      { "<Leader>Di", function() require("dap").step_into() end,                                                       mode = "n",          desc = "[DAP] Step into" },
      { "<Leader>DO", function() require("dap").step_out() end,                                                        mode = "n",          desc = "[DAP] Step out" },
      { "<Leader>Dq", function() require("dap").terminate() end,                                                       mode = "n",          desc = "[DAP] Terminate" },
      { "<Leader>Db",  function() require("dap").toggle_breakpoint() end,                                              mode = "n",          desc = "[DAP] Toggle breakpoint" },
      { "<Leader>DB",  function() require("dap").set_breakpoint() end,                                                 mode = "n",          desc = "[DAP] Set breakpoint" },
      -- Remove the <leader>D binding in "x" mode
      { "<Leader>D" , mode = "x" },
      { "<Leader>Dr", function() require("dap").repl.open() end,                                                       mode = "n",          desc = "[DAP] Repl open" },
      { "<Leader>Dl", function() require("dap").run_last() end,                                                        mode = "n",          desc = "[DAP] Run last" },
      { "<Leader>Dd", function() require("dap.ui.widgets").hover() end,                                                mode = { "n", "v" }, desc = "[DAP] Widgets hover" },
      { "<Leader>Dp", function() require("dap.ui.widgets").preview() end,                                              mode = { "n", "v" }, desc = "[DAP] Widgets preview" },
      { "<Leader>Df", function() local widgets = require("dap.ui.widgets") widgets.centered_float(widgets.frames) end, mode = {"n"},        desc = "[DAP] Float frames" },
      { "<Leader>Ds", function() local widgets = require("dap.ui.widgets") widgets.centered_float(widgets.scopes) end, mode = {"n"},        desc = "[DAP] Float scopes" },
    },

    opts = function()
      --stylua: ignore
      local dap_breakpoint = {
        breakpoint = { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }, -- Nerd font: nf-cod-activate_breakpoints
        condition  = { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" },
        rejected   = { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" },
        logpoint   = { text = "", texthl = "DapLogPoint",   linehl = "DapLogPoint",   numhl = "DapLogPoint"   },
        stopped    = { text = "", texthl = "DapStopped",    linehl = "DapStopped",    numhl = "DapStopped"    },
      }
      vim.fn.sign_define("DapBreakpoint", dap_breakpoint.breakpoint)
      vim.fn.sign_define("DapBreakpointCondition", dap_breakpoint.condition)
      vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
      vim.fn.sign_define("DapLogPoint", dap_breakpoint.logpoint)
      vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
    end,

    config = function()
      local dap = require("dap")
      dap.defaults.fallback.external_terminal = {
        command = "wezterm",
      }

      -- Fix: Disable winfixbuf before DAP jumps to source location
      -- This prevents "E1513: Cannot switch buffer. 'winfixbuf' is enabled" error
      dap.listeners.before.event_stopped["fix_winfixbuf"] = function()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_is_valid(win) then
            local buf = vim.api.nvim_win_get_buf(win)
            local ft = vim.bo[buf].filetype
            -- Only disable winfixbuf for normal code windows, not for special buffers
            if not vim.tbl_contains({ "dap-repl", "dap-view", "dap-view-term", "snacks_picker" }, ft) then
              pcall(vim.api.nvim_set_option_value, "winfixbuf", false, { win = win })
            end
          end
        end
      end
    end,
  },
}
