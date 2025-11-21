return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    mappings = {
      submit_prompt = {
        normal = '<Leader>s',
        insert = '<C-s>'
      }
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
