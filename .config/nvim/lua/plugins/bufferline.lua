local api, fn = vim.api, vim.fn

return {
  'akinsho/bufferline.nvim',
  version = "*",
  event = 'UIEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local bufferline = require('bufferline')
    bufferline.setup({
      options = {
        debug = { logging = true },
        style_preset = { bufferline.style_preset.minimal },
        mode = 'buffers',
        sort_by = 'insert_after_current',
        move_wraps_at_ends = true,
        right_mouse_command = 'vert sbuffer %d',
        show_close_icon = false,
        show_buffer_close_icons = true,
        indicator = { style = 'underline' },
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level)
          level = level:match('warn') and 'warn' or level
          return ('' or '') .. ' ' .. count
        end,
        diagnostics_update_in_insert = false,
        hover = { enabled = true, reveal = { 'close' } },
        offsets = {
          {
            text = 'EXPLORER',
            filetype = 'neo-tree',
            highlight = 'PanelHeading',
            text_align = 'left',
            separator = true,
          },
          {
            text = ' FLUTTER OUTLINE',
            filetype = 'flutterToolsOutline',
            highlight = 'PanelHeading',
            separator = true,
          },
          {
            text = 'UNDOTREE',
            filetype = 'undotree',
            highlight = 'PanelHeading',
            separator = true,
          },
          {
            text = '󰆼 DATABASE VIEWER',
            filetype = 'dbui',
            highlight = 'PanelHeading',
            separator = true,
          },
          {
            text = ' DIFF VIEW',
            filetype = 'DiffviewFiles',
            highlight = 'PanelHeading',
            separator = true,
          },
        },
        groups = {
          options = { toggle_hidden_on_enter = true },
          items = {
            bufferline.groups.builtin.pinned:with({ icon = '' }),
            bufferline.groups.builtin.ungrouped,
            {
              name = 'Dependencies',
              icon = '',
              highlight = { fg = '#ECBE7B' },
              matcher = function(buf) return vim.startswith(buf.path, vim.env.VIMRUNTIME) end,
            },
            {
              name = 'Terraform',
              matcher = function(buf) return buf.name:match('%.tf') ~= nil end,
            },
            {
              name = 'Kubernetes',
              matcher = function(buf) return buf.name:match('kubernetes') and buf.name:match('%.yaml') end,
            },
            {
              name = 'SQL',
              icon = "󰆼", --  
              matcher = function(buf) return buf.name:match('%.sql$') end,
            },
            {
              name = 'tests',
              icon = '󰙨', -- 
              matcher = function(buf)
                local name = buf.name
                return name:match('[_%.]spec') or name:match('[_%.]test')
              end,
            },
            {
              name = 'docs',
              icon = '',
              matcher = function(buf)
                if vim.bo[buf.id].filetype == 'man' or buf.path:match('man://') then return true end
                for _, ext in ipairs({ 'md', 'txt', 'org', 'norg', 'wiki' }) do
                  if ext == fn.fnamemodify(buf.path, ':e') then return true end
                end
              end,
            },
          },
        },
      },
    })

    local keymap = vim.keymap.set

    keymap('n', '[b', '<Cmd>BufferLineMoveNext<CR>', { desc = 'bufferline: move next' })
    keymap('n', ']b', '<Cmd>BufferLineMovePrev<CR>', { desc = 'bufferline: move prev' })
    keymap('n', 'gbb', '<Cmd>BufferLinePick<CR>', { desc = 'bufferline: pick buffer' })
    keymap('n', 'gbd', '<Cmd>BufferLinePickClose<CR>', { desc = 'bufferline: delete buffer' })
    keymap('n', '<S-tab>', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'bufferline: prev' })
    keymap('n', '<leader><tab>', '<Cmd>BufferLineCycleNext<CR>', { desc = 'bufferline: next' })
  end,
}
