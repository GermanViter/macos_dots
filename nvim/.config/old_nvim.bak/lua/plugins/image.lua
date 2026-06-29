return {
    "3rd/image.nvim",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    opts = {
        processor = "magick_cli",
    },
    config = function(_, opts)
        local ok, image = pcall(require, "image")
        if ok then
            pcall(image.setup, opts)
        end
    end,
}
