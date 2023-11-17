require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  numhl = false,
  linehl = false,
  watch_gitdir = {
    interval = 1000
  },
  current_line_blame = false,
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  on_attach = function(bufnr)
    local function buf_set_keymap(mode, key, func)
      vim.keymap.set(mode, key, func, { buffer = bufnr, silent = true })
    end

    buf_set_keymap('n', ']c', require('gitsigns').next_hunk)
    buf_set_keymap('n', '[c', require('gitsigns').prev_hunk)
    buf_set_keymap('n', '<leader>gs', require"gitsigns".stage_hunk)
    buf_set_keymap('n', '<leader>gu', require"gitsigns".undo_stage_hunk)
    buf_set_keymap('n', '<leader>gr', require"gitsigns".reset_hunk)
    buf_set_keymap('n', '<leader>gR', require"gitsigns".reset_buffer)
    buf_set_keymap('n', '<leader>gp', require"gitsigns".preview_hunk)
    buf_set_keymap('n', '<leader>gb', require"gitsigns".blame_line)
    buf_set_keymap('n', '<leader>gS', require"gitsigns".stage_buffer)
    buf_set_keymap('n', '<leader>gU', require"gitsigns".reset_buffer_index)
  end
}
