-- https://github.com/goolord/alpha-nvim
return {
  -- shows an initial screen with options 
  "goolord/alpha-nvim",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    
    local function header()
      --return require("ascii").art.animals.dogs.lucky
      return require("ascii").get_random("text", "neovim")
    end

    dashboard.section.header.val = header()

    dashboard.section.buttons.val = {
      dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("o", "📂  Open file", ":Telescope find_files<CR>"),
      dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
      dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
    }

    local function footer()
      local datetime = os.date "%d-%m-%Y %H:%M:%S"
      local plugins_text = 
        "   v"
        .. vim.version().major
        .. "."
        .. vim.version().minor
        .. "."
        .. vim.version().patch
        .. "   "
        .. datetime
    
      -- Quote
      local fortune = require("alpha.fortune")
      local quote = table.concat(fortune(), "\n")

      return plugins_text .. "\n" .. quote
    end
  

    dashboard.section.footer.val = footer()

    dashboard.section.footer.opts.hl = "Constant"
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Function"
    dashboard.section.buttons.opts.hl_shortcut = "Type"
    dashboard.opts.opts.noautocmd = true

    alpha.setup(dashboard.opts)
  end,
}
