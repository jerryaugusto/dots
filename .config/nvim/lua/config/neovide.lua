-- Neovide configuration

if not vim.g.neovide then return end

local g = vim.g

-- base
g.neovide_transparency = g.gui_transparency_default

g.neovide_scale_factor = 1.0

g.neovide_underline_stroke_scale = 2.0
g.neovide_hide_mouse_when_typing = true

vim.opt.guicursor = {
	"i-ci-c:ver25",
	"n-sm:block",
	"r-cr-o-v:hor10",
	"a:blinkwait200-blinkoff350-blinkon550",
}

g.neovide_cursor_animation_length = 0.01
g.neovide_cursor_trail_size = 0.9
g.neovide_cursor_unfocused_outline_width = 0.1
g.neovide_cursor_vfx_mode = "railgun" -- railgun|torpedo|pixiedust|sonicboom|ripple|wireframe

g.neovide_cursor_animate_in_insert_mode = true
g.neovide_cursor_animate_command_line = true

-- only railgun, torpedo, and pixiedust
g.neovide_cursor_vfx_particle_lifetime = 0.8
g.neovide_cursor_vfx_particle_density = 20.0
g.neovide_cursor_vfx_particle_speed = 40.0

-- only railgun
g.neovide_cursor_vfx_particle_phase = 1.3
g.neovide_cursor_vfx_particle_curl = 1.3

g.gui_font_default_size = 11
g.gui_font_size = g.gui_font_default_size
-- g.gui_font_face = "Agave Nerd Font"
-- g.gui_font_face = "JetBrainsMono Nerd Font"
g.gui_font_face = "Maple Mono"

-- Screen Manipulation
local function toggleTransparency()
  if g.neovide_transparency == 1.0 then
    vim.cmd(string.format("let g:neovide_transparency=%s", g.gui_transparency_default))
  else
    vim.cmd "let g:neovide_transparency=1.0"
  end
end

local function toggleFullscreen()
  if g.neovide_fullscreen == false then
    vim.cmd "let g:neovide_fullscreen=v:true"
  else
    vim.cmd "let g:neovide_fullscreen=v:false"
  end
end

-- Runtime Font Resize
RefreshGuiFont = function()
  vim.opt.guifont = string.format("%s:h%s", g.gui_font_face, g.gui_font_size)
end

ResizeGuiFont = function(delta)
  g.gui_font_size = g.gui_font_size + delta
  RefreshGuiFont()
end

ResetGuiFont = function()
  g.gui_font_size = g.gui_font_default_size
  RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

-- Keymap
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap({ "n", "i" }, "<F12>", function()
  ResizeGuiFont(1)
end, opts)
keymap({ "n", "i" }, "<F11>", function()
  ResizeGuiFont(-1)
end, opts)
keymap({ "n", "i" }, "<F10>", function()
  ResetGuiFont()
end, opts)
keymap("n", "<F8>", toggleFullscreen, opts)
keymap("n", "<F9>", toggleTransparency, opts)

keymap("i", "<C-BS>", "<Esc>ciw", opts) -- Ctrl + backspace delete a word

-- Clipboard system
keymap({ "n", "v" }, "<C-c>", '"+y', opts) -- nmap <c-c> "+y
keymap({ "n", "v" }, "<C-v>", '"+p', opts) -- nmap <c-v> "+p
keymap("i", "<C-v>", "<C-r>+", opts)       -- inoremap <c-v> <c-r>+
keymap("c", "<C-v>", "<C-r>+", opts)       -- cnoremap <c-v> <c-r>+
-- use <C-r> to insert original character without triggering things like auto-pairs
keymap("i", "<C-r>", "<C-v>", opts)        -- inoremap <c-r> <c-v>
