-- Ensure lazy.nvim is installed (if not, clone it)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",

    "clone",
    "--filter=blob:none",

    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })

end
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim and your plugin configurations

require("lazy").setup("lamiman.plugins", {
  checker = {
    enabled = true, -- Enables plugin checker for updates
    notify = false, -- No notifications
  },
  change_detection = {
    notify = false, -- Disable notifications for file changes
  },
})

