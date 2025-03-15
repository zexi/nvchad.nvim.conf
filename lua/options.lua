require "nvchad.options"

-- add yours here!

local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
o.cursorlineopt ='line' -- to enable cursorline!
vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#3c3836' })
o.mouse = ""

local options = {
  scrolloff = 5, -- is one of my fav, keep in center
  wrap = true,   -- not display lines as one long line
  listchars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣",
  history = 10000,
  signcolumn = "no",                      -- always show the sign column, otherwise it would shift the text each time
}
for k, v in pairs(options) do
  vim.opt[k] = v
end

local autocmd = vim.api.nvim_create_autocmd

autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})


vim.cmd [[
  augroup _file_type_setting
    autocmd FileType go,make setlocal sw=4 tabstop=4 noexpandtab
  augroup end

  augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
  augroup end
]]

local wr_group = vim.api.nvim_create_augroup('WinResize', { clear = true })
vim.api.nvim_create_autocmd(
  'VimResized',
  {
    group = wr_group,
    pattern = '*',
    command = 'wincmd =',
    desc = 'Automatically resize windows when the host window size changes.'
  }
)
