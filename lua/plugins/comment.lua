-- https://github.com/numToStr/Comment.nvim
return {
   'numToStr/Comment.nvim',
    config = function()
        -- gcc : Comment in normal mode
        -- gc : Comment in visual mode
        require('Comment').setup()
    end
}
