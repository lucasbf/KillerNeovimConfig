-- https://github.com/mfussenegger/nvim-dap
return {
  {
    -- A Debbug Adapter Protocol for NVIM
    "mfussenegger/nvim-dap",
    dependencies = {},
    config = function()
      local dap = require("dap")

      local function pick_dap_config()
        local ft = vim.bo.filetype
        local configs = dap.configurations[ft]

        if not configs or vim.tbl_isempty(configs) then
          vim.notify("Nenhuma configuração DAP para filetype: " .. ft, vim.log.levels.ERROR)
          return
        end

        vim.ui.select(configs, {
          prompt = "Escolha a configuração DAP:",
          format_item = function(item)
            return item.name
          end,
        }, function(choice)
          if choice then
            dap.run(choice)
          end
        end)
      end
      dap.set_log_level("ERROR")
      -- Keymaps
      vim.keymap.set("n", "<leader>db", function()
        dap.toggle_breakpoint()
      end)
      --vim.keymap.set("n", "<F5>", function()
      --  dap.continue()
      --end)
      vim.keymap.set("n", "<F5>", pick_dap_config, { desc = "Selecionar configuração DAP e iniciar" })
      vim.keymap.set("n", "<leader>dc", function()
        dap.run_to_cursor()
      end)
      vim.keymap.set("n", "<leader>dt", function()
        dap.terminate()
      end)
      
      --[[
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
          cmd = vim.fn.expand("~/.pyenv/shims/python")
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
              return vim.fn.expand("~/.pyenv/shims/python")
            end
          end,
        },
      }
      -- C/C++ (via lldb-dap)
      dap.adapters.lldb = {
        type = "executable",
        command = "lldb-dap", -- use PATH-resolved binary instead of absolute path
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
      ]]
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    ---@type MasonNvimDapSettings
    opts = {
      -- This line is essential to making automatic installation work
      -- :exploding-brain
      handlers = {},
      automatic_installation = {
        -- These will be configured by separate plugins.
        exclude = {
          "python",
        },
      },
      -- DAP servers: Mason will be invoked to install these if necessary.
      ensure_installed = {
        "bash",
        "codelldb",
        "python",
      },
    },
    dependencies = {
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim",
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      -- Detecta o Python do projeto
      local cwd = vim.fn.getcwd()
      local python

      if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
        python = cwd .. "/.venv/bin/python"
      elseif vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
        python = cwd .. "/venv/bin/python"
      else
        -- fallback: python “global” (pyenv, etc)
        python = vim.fn.exepath("python")
      end
      
      print(python)

      require("dap-python").setup(python)
      --local python = vim.fn.expand("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
      --require("dap-python").setup(python)
      local dap = require("dap")
      local project_root = vim.fn.getcwd()
      -- Config extra: Flask
      table.insert(dap.configurations.python, {
        type = "python",
        request = "launch",
        name = "Flask Debug",
        module = "flask",
        cwd = project_root,
        env = {
          FLASK_APP = "wsgi.py",
          FLASK_ENV = "development",
          PYTHONPATH = project_root,
        },
        args = {
          "run",
          "--debug",
          "--host", "0.0.0.0",
          "--port", "5002",
        },
        console = "integratedTerminal",
        justMyCode = false,
      })
    end,
    -- Consider the mappings at
    -- https://github.com/mfussenegger/nvim-dap-python?tab=readme-ov-file#mappings
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = true,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
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
      vim.keymap.set("n", "<leader>dx", function()
        dap.terminate()
        dapui.close()
      end)
      --[[
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
      ]]
    end,
  },
}
