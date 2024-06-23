require "config.options"
require "config.keymap"
require "config.lazy"
require "config.autocmds"

if vim.g.neovide then
  require "config.neovide"
end
