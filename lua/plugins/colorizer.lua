-- https://github.com/norcalli/nvim-colorizer.lua
return {
  -- Set background word color with code/name
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			"*", -- Highlight all files, but customize some others.
			css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in css.
			html = { names = true }, -- Enable parsing "names" like Blue or Gray
		})
	end,
}
