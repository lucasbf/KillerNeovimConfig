-- https://github.com/mfussenegger/nvim-dap
return {
  {
    -- A Debbug Adapter Protocol for NVIM
    "mfussenegger/nvim-dap",
    dependencies = {},
    config = function()
      local dap = require("dap")
      dap.set_log_level("ERROR")
      -- Keymaps
      vim.keymap.set("n", "<Leader>dt", function()
        dap.toggle_breakpoint()
      end)
      vim.keymap.set("n", "<F5>", function()
        dap.continue()
      end)

      -- Python DAP
      dap.adapters.python = function(cb, config)
        local cwd = vim.fn.getcwd()
        local env = os.getenv("VIRTUAL_ENV")
        local cmd = ""
        if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
          cmd = cwd .. "/venv/bin/python"
        elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
          cmd = cwd .. "/.venv/bin/python"
        elseif env ~= nil then
          cmd = env .. "/bin/python"
        else
          cmd = "/Users/lucasbf/.pyenv/shims/python"
        end

        if config.request == "attach" then
          ---@diagnostic disable-next-line: undefined-field
          local port = (config.connect or config).port
          ---@diagnostic disable-next-line: undefined-field
          local host = (config.connect or config).host or "127.0.0.1"
          cb({
            type = "server",
            port = assert(port, "`connect.port` is required for a python `attach` configuration"),
            host = host,
            options = {
              source_filetype = "python",
            },
          })
        else
          cb({
            type = "executable",
            command = cmd,
            args = { "-m", "debugpy.adapter" },
            options = {
              source_filetype = "python",
            },
          })
        end
      end
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",

          program = "${file}",
          pythonPath = function()
            local cwd = vim.fn.getcwd()
            local env = os.getenv("VIRTUAL_ENV")
            if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
              return cwd .. "/venv/bin/python"
            elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
              return cwd .. "/.venv/bin/python"
            elseif env ~= nil then
              return env .. "/bin/python"
            else
              return "/Users/lucasbf/.pyenv/shims/python"
            end
          end,
        },
      }
      -- C/C++ (via lldb-dap)
      dap.adapters.lldb = {
        type = "executable",
        command = "/usr/local/opt/llvm/bin/lldb-dap", -- adjust as needed, must be absolute path
        name = "lldb",
      }
      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
    end,
  },
  --[[
  {
    "mfussenegger/nvim-dap-python",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      -- Python DAP
      local env = os.getenv("VIRTUAL_ENV")
      if env == nil then
        require("dap-python").setup("/Users/lucasbf/.pyenv/shims/python")
      else
        require("dap-python").setup(env .. "/bin/python")
      end
    end,
  },
  ]]
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("dapui").setup()
      -- Link DAP <-> DAPUI
      local dap = require("dap")
      local dapui = require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
}
